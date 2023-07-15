import 'package:demos_app/data.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_example/common.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

class PlayView extends StatefulWidget {
  const PlayView({super.key});

  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> with WidgetsBindingObserver {
  late AudioPlayer _player;
  final _playlist = ConcatenatingAudioSource(children: [
    // Remove this audio source from the Windows and Linux version because it's not supported yet
    if (kIsWeb ||
        ![TargetPlatform.windows, TargetPlatform.linux]
            .contains(defaultTargetPlatform))
      ClippingAudioSource(
        start: const Duration(seconds: 60),
        end: const Duration(seconds: 90),
        child: AudioSource.uri(Uri.parse(
            "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")),
        tag: AudioMetadata(
          album: "Science Friday",
          title: "A Salute To Head-Scratching Science (30 seconds)",
          artwork:
              "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
        ),
      ),
    AudioSource.uri(
      Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"),
      tag: AudioMetadata(
        album: "Science Friday",
        title: "A Salute To Head-Scratching Science",
        artwork:
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
      ),
    ),
    AudioSource.uri(
      Uri.parse("https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
      tag: AudioMetadata(
        album: "Science Friday",
        title: "From Cat Rheology To Operatic Incompetence",
        artwork:
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///audio/nature.mp3"),
      tag: AudioMetadata(
        album: "Public Domain",
        title: "Nature Sounds",
        artwork:
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
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
      appBar: AppBar(
        backgroundColor: const Color(0xff141616),
        elevation: 0,
        title: SizedBox(
          width: 320,
          child: Text(
            'Playlist',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8999999761581421),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.10,
            ),
          ),
        ),
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: const Color(0xff141616),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              // width: 368,
              height: 310,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage("images/plist.png"),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              width: 368,
              height: 63,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'X exclusives',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Lonely mix',
                              style: TextStyle(
                                color: Color(0xFFD5FFE4),
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 168),
                  Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Image.asset("images/heart.png"),
                  ),
                ],
              ),
            ),
            Opacity(
              opacity: 0.60,
              child: Container(
                width: 368,
                height: 110,
                decoration: ShapeDecoration(
                  color: const Color(0x19DEDBDB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Opacity(
                        opacity: 0.70,
                        child: Text(
                          'Snooze                    SZA                            3:19',
                          style: TextStyle(
                            color: Color(0xFFF2F2F2),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.07,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Opacity(
                        opacity: 0.70,
                        child: Text(
                          'Kill Bill                     SZA                            2:33',
                          style: TextStyle(
                            color: Color(0xFFF2F2F2),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.07,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/shuffle.png",
                ),
                const Spacer(),
                Image.asset(
                  "images/skip-back.png",
                ),
                const Spacer(),
                Hero(
                  tag: "play",
                  child: GestureDetector(
                    onTap: () async {},
                    child: Container(
                      width: 83.53,
                      height: 81.53,
                      decoration: const ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFFB5D2BF), Color(0xFFD5FFE4)],
                        ),
                        shape: OvalBorder(),
                      ),
                      child: Center(
                        child: Image.asset("images/play.png"),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Image.asset(
                  "images/skip-forward.png",
                ),
                const Spacer(),
                Image.asset(
                  "images/repeat.png",
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

List playList = [
  {
    "title": "Where_is_Love",
    "artist": "StoneBoy",
    "url":
        "https://res.cloudinary.com/citizen/video/upload/v1689357065/AudioFiles/STONEBWOY_-_Where_is_the_Love_-_Visualiser_2.0_128_kbps_sa89qq.mp3",
  },
  {
    "title": "Non_Stop",
    "artist": "StoneBoy",
    "url":
        "https://res.cloudinary.com/citizen/video/upload/v1689358036/AudioFiles/Stonebwoy_-_Non_Stop_Visualizer_128_kbps_yygyqm.mp3",
  },
  {
    "title": "Into_The_Future",
    "artist": "StoneBoy",
    "url":
        "https://res.cloudinary.com/citizen/video/upload/v1689356892/AudioFiles/Stonebwoy_-_Into_The_Future_Official_Music_Video_128_kbps_pxe7o0.mp3",
  }
];
