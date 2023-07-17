// ignore_for_file: depend_on_referenced_packages

import 'package:demos_app/components/new_release.dart';
import 'package:demos_app/components/opacity_card.dart';
import 'package:demos_app/data.dart';
import 'package:demos_app/player_view.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  late AudioPlayer _player;
  final _playlist = ConcatenatingAudioSource(children: [
    if (kIsWeb ||
        ![TargetPlatform.windows, TargetPlatform.linux]
            .contains(defaultTargetPlatform))
      ClippingAudioSource(
        child: AudioSource.uri(Uri.parse(
            "https://res.cloudinary.com/citizen/video/upload/v1689356892/AudioFiles/Stonebwoy_-_Into_The_Future_Official_Music_Video_128_kbps_pxe7o0.mp3")),
        tag: AudioMetadata(
          album: "Into The Future Official Music",
          title: "StoneBwoy",
          artwork: "images/img1.png",
        ),
      ),
    AudioSource.uri(
      Uri.parse(
          "https://res.cloudinary.com/citizen/video/upload/v1689421036/AudioFiles/SHATTA_WALE_-_ON_GOD_OFFICIAL_VIDEO_64_kbps_lvhhyk.mp3"),
      tag: AudioMetadata(
        album: "ON GOD OFFICIAL",
        title: "ShatTA_WALE",
        artwork: "images/mag1.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://res.cloudinary.com/citizen/video/upload/v1689421031/AudioFiles/Shatta_Wale_-_Taking_Over_ft._Joint_77_Addi_Self_Captan_Official_Video_64_kbps_umlnky.mp3"),
      tag: AudioMetadata(
        album: "TAKING OVER",
        title: "ShatTa_WALE",
        artwork: "images/mag2.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://res.cloudinary.com/citizen/video/upload/v1689357065/AudioFiles/STONEBWOY_-_Where_is_the_Love_-_Visualiser_2.0_128_kbps_sa89qq.mp3"),
      tag: AudioMetadata(
        album: "StoneBWOY",
        title: "Where is the Love",
        artwork: "images/mag3.png",
      ),
    ),
  ]);
  int _addedCount = 0;
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      // Preloading audio is not currently supported on Linux.
      await _player.setAudioSource(_playlist,
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
    } catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading audio source: $e");
    }
    // Show a snackbar whenever reaching the end of an item in the playlist.
    _player.positionDiscontinuityStream.listen((discontinuity) {
      if (discontinuity.reason == PositionDiscontinuityReason.autoAdvance) {
        _showItemFinished(discontinuity.previousEvent.currentIndex);
      }
    });
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _showItemFinished(_player.currentIndex);
      }
    });
  }

  void _showItemFinished(int? index) {
    if (index == null) return;
    final sequence = _player.sequence;
    if (sequence == null) return;
    final source = sequence[index];
    final metadata = source.tag as AudioMetadata;
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text('Finished playing ${metadata.title}'),
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: 428,
        // height: 926,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF141616)),
        child: Stack(
          children: [
            Positioned(
              left: -129,
              top: -49,
              child: StreamBuilder<SequenceState?>(
                stream: _player.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state?.sequence.isEmpty ?? true) {
                    return const SizedBox();
                  }
                  final metadata = state!.currentSource!.tag as AudioMetadata;
                  return Container(
                    width: 686,
                    height: 386,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(metadata.artwork.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              top: 21,
              child: Container(
                width: 428,
                height: 645,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0x00141616), Color(0xFF141616)],
                  ),
                ),
              ),
            ),
            ///////////////////////////////////////////////////////////
            Positioned(
              // left: 30,
              top: 256,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<SequenceState?>(
                        stream: _player.sequenceStateStream,
                        builder: (context, snapshots) {
                          final state = snapshots.data;
                          if (state?.sequence.isEmpty ?? true) {
                            return const SizedBox(
                              child: Text("kjabdfjhbadhjfbdajhbjsdhab"),
                            );
                          }
                          final metadata =
                              state!.currentSource!.tag as AudioMetadata;

                          return SizedBox(
                            height: 134,
                            // color: Colors.blue,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              metadata.album,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            metadata.title,
                                            style: const TextStyle(
                                              color: Color(0xFFD5FFE4),
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const OpacityCards(
                                                image: "images/fav.png",
                                              ),
                                              const SizedBox(width: 16),
                                              const OpacityCards(
                                                image: "images/sys.png",
                                              ),
                                              const SizedBox(width: 16),

                                              OpacityCards(
                                                image: "images/vol.png",
                                                onTap: () => showSliderDialog(
                                                  context: context,
                                                  title: "Adjust volume",
                                                  divisions: 10,
                                                  min: 0.0,
                                                  max: 1.0,
                                                  value: _player.volume,
                                                  stream: _player.volumeStream,
                                                  onChanged: _player.setVolume,
                                                ),
                                              ),
                                              // const SizedBox(width: 10),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(height: 19),
                                    ],
                                  ),
                                ),
                                //
                                //
                                // const SizedBox(width: 109),
                                Hero(
                                  tag: "play",
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: const ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(0.99, -0.12),
                                        end: Alignment(-0.99, 0.12),
                                        colors: [
                                          Color(0xC1DDFFE9),
                                          Color(0xF7D5FFE4)
                                        ],
                                      ),
                                      shape: OvalBorder(),
                                    ),
                                    child: StreamBuilder<PlayerState>(
                                      stream: _player.playerStateStream,
                                      builder: (context, snapshot) {
                                        final playerState = snapshot.data;
                                        final processingState =
                                            playerState?.processingState;
                                        final playing = playerState?.playing;
                                        if (processingState ==
                                                ProcessingState.loading ||
                                            processingState ==
                                                ProcessingState.buffering) {
                                          return Container(
                                            margin: const EdgeInsets.all(8.0),
                                            width: 64.0,
                                            height: 64.0,
                                            child:
                                                const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Color(0xFF141616)),
                                            ),
                                          );
                                        } else if (playing != true) {
                                          return Material(
                                            shape: const OvalBorder(),
                                            color: const Color(0xC1DDFFE9),
                                            child: IconButton(
                                              icon: Image.asset(
                                                  "images/play.png"),
                                              iconSize: 64.0,
                                              onPressed: _player.play,
                                            ),
                                          );
                                        } else if (processingState !=
                                            ProcessingState.completed) {
                                          return Material(
                                            color: const Color(0xC1DDFFE9),
                                            shape: const OvalBorder(),
                                            child: IconButton(
                                              icon: Image.asset(
                                                  "images/pause.png"),
                                              iconSize: 64.0,
                                              onPressed: _player.pause,
                                            ),
                                          );
                                        } else {
                                          return IconButton(
                                            icon: const Icon(Icons.replay),
                                            iconSize: 64.0,
                                            onPressed: () => _player.seek(
                                                Duration.zero,
                                                index: _player
                                                    .effectiveIndices!.first),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );

                          //////////////////////////////
                        }),
                    StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return SeekBar(
                          duration: positionData?.duration ?? Duration.zero,
                          position: positionData?.position ?? Duration.zero,
                          bufferedPosition:
                              positionData?.bufferedPosition ?? Duration.zero,
                          onChangeEnd: (newPosition) {
                            _player.seek(newPosition);
                          },
                        );
                      },
                    ),

                    /////////////////
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Releases',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8999999761581421),
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.11,
                          ),
                        ),
                        GestureDetector(
                          ////////////
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PlayView(
                                        player: _player,
                                        positionDataStream: _positionDataStream,
                                      ))),
                          child: Container(
                            width: 70,
                            height: 32,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5.50),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              'Expand',
                              style: TextStyle(
                                color: Colors.white
                                    .withOpacity(0.8999999761581421),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: StreamBuilder<SequenceState?>(
                        stream: _player.sequenceStateStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          final sequence = state?.sequence ?? [];
                          return ReorderableListView(
                            onReorder: (int oldIndex, int newIndex) {
                              if (oldIndex < newIndex) newIndex--;
                              _playlist.move(oldIndex, newIndex);
                            },
                            children: [
                              for (var i = 0; i < sequence.length; i++)
                                Dismissible(
                                  key: ValueKey(sequence[i]),
                                  background: Container(
                                    color: Colors.redAccent,
                                    alignment: Alignment.centerRight,
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onDismissed: (dismissDirection) {
                                    _playlist.removeAt(i);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Material(
                                        color: i == state!.currentIndex
                                            ? const Color.fromARGB(
                                                255, 29, 30, 30)
                                            : const Color(0xFF141616),
                                        child: NewReleaseCompnent(
                                          title:
                                              sequence[i].tag.title as String,
                                          subTitle:
                                              sequence[i].tag.album as String,
                                          imageTitle:
                                              sequence[i].tag.artwork as String,
                                          onTap: () {
                                            _player.seek(Duration.zero,
                                                index: i);
                                          },
                                        )),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
