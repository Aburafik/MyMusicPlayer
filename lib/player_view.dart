import 'package:demos_app/data.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
class PlayView extends StatefulWidget {
  const PlayView({super.key, this.player, this.positionDataStream});
  final AudioPlayer? player;
  final Stream<PositionData>? positionDataStream;
  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> with WidgetsBindingObserver {
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
            StreamBuilder<SequenceState?>(
              stream: widget.player!.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return const SizedBox();
                }
                final metadata = state!.currentSource!.tag as AudioMetadata;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // width: 368,
                      height: 310,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage(metadata.artwork),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      // color: Color.fromRGBO(244, 67, 54, 1),
                      width: 368,
                      height: 70,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    metadata.title,
                                    style: const TextStyle(
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
                          // const SizedBox(width: 168),
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
                  ],
                );
              },
            ),
            StreamBuilder<PositionData>(
              stream: widget.positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: (newPosition) {
                    widget.player!.seek(newPosition);
                  },
                );
              },
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
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                StreamBuilder<bool>(
                  stream: widget.player!.shuffleModeEnabledStream,
                  builder: (context, snapshot) {
                    final shuffleModeEnabled = snapshot.data ?? false;
                    return GestureDetector(
                      child: Image.asset(
                        "images/shuffle.png",
                        color: shuffleModeEnabled
                            ? Colors.orange
                            : const Color(0xffF2F2F2),
                      ),
                      onTap: () async {
                        final enable = !shuffleModeEnabled;
                        if (enable) {
                          await widget.player!.shuffle();
                        }
                        await widget.player!.setShuffleModeEnabled(enable);
                      },
                    );
                  },
                ),

                const Spacer(),

                ///PREVIOUS BUTTON

                StreamBuilder<SequenceState?>(
                  stream: widget.player!.sequenceStateStream,
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        widget.player!.seekToPrevious();
                        // sequence.isNotEmpty ? sequence.length - 1 : null;
                      },
                      child: Image.asset(
                        "images/skip-back.png",
                      ),
                    );
                  },
                ),

                const Spacer(),

                ////PLAY BUTTON
                Hero(
                  tag: "play",
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.99, -0.12),
                        end: Alignment(-0.99, 0.12),
                        colors: [Color(0xC1DDFFE9), Color(0xF7D5FFE4)],
                      ),
                      shape: OvalBorder(),
                    ),
                    child: StreamBuilder<PlayerState>(
                      stream: widget.player!.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        final playing = playerState?.playing;
                        if (processingState == ProcessingState.loading ||
                            processingState == ProcessingState.buffering) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            width: 64.0,
                            height: 64.0,
                            child: const CircularProgressIndicator(),
                          );
                        } else if (playing != true) {
                          return Material(
                            shape: const OvalBorder(),
                            color: const Color(0xC1DDFFE9),
                            child: IconButton(
                              icon: Image.asset("images/play.png"),
                              iconSize: 64.0,
                              onPressed: widget.player!.play,
                            ),
                          );
                        } else if (processingState !=
                            ProcessingState.completed) {
                          return Material(
                            color: const Color(0xC1DDFFE9),
                            shape: const OvalBorder(),
                            child: IconButton(
                              icon: Image.asset("images/pause.png"),
                              iconSize: 64.0,
                              onPressed: widget.player!.pause,
                            ),
                          );
                        } else {
                          return IconButton(
                            icon: const Icon(Icons.replay),
                            iconSize: 64.0,
                            onPressed: () => widget.player!.seek(Duration.zero,
                                index: widget.player!.effectiveIndices!.first),
                          );
                        }
                      },
                    ),
                  ),
                ),

                const Spacer(),
                StreamBuilder<SequenceState?>(
                  stream: widget.player!.sequenceStateStream,
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        widget.player!.seekToNext();
                      },
                      child: Image.asset(
                        "images/skip-forward.png",
                      ),
                    );
                  },
                ),
                // Image.asset(
                //   "images/skip-forward.png",
                // ),
                const Spacer(),

                StreamBuilder<LoopMode>(
                  stream: widget.player!.loopModeStream,
                  builder: (context, snapshot) {
                    final loopMode = snapshot.data ?? LoopMode.off;
                    List images = [
                      const Icon(
                        Icons.repeat,
                        color: Color(0xffF2F2F2),
                        size: 32,
                      ),
                      const Icon(Icons.repeat, color: Colors.orange),
                      const Icon(Icons.repeat_one, color: Colors.orange),
                    ];
                    const cycleModes = [
                      LoopMode.off,
                      LoopMode.all,
                      LoopMode.one,
                    ];
                    final index = cycleModes.indexOf(loopMode);
                    return GestureDetector(
                      child: images[index],
                      onTap: () {
                        widget.player!.setLoopMode(cycleModes[
                            (cycleModes.indexOf(loopMode) + 1) %
                                cycleModes.length]);
                      },
                    );
                  },
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
