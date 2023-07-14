import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayView extends StatefulWidget {
  const PlayView({super.key});

  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> {
  final player = AudioPlayer();
  @override
  void initState() {
    playAudio();
    // playerStreamer();
    super.initState();
  }

  playerStreamer() {
    player.bufferedPositionStream.listen((state) {
      print(state.inMinutes);
      print("processing");
    });
  }

  playAudio() async {
    try {
      await player.setUrl(
          "https://res.cloudinary.com/citizen/video/upload/v1689356892/AudioFiles/Stonebwoy_-_Into_The_Future_Official_Music_Video_128_kbps_pxe7o0.mp3");
    } on PlayerException catch (e) {
      print("Error code: ${e.code}");

      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("Connection aborted: ${e.message}");
    } catch (e) {
      print('An error occured: $e');
    }
  }

  bool play = false;
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
                    onTap: () async {
                      setState(() {
                        play = !play;

                        play ? player.play() : player.pause();
                        playerStreamer();
                        print(
                            ":::::::::::::::::::::::::::${player.playing}::::::::::::::::::::::::::::::::::");
                    
                      });
                      print("Playing now...");
                      print(player.bufferedPosition.inSeconds);
                    },
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
                        child: Image.asset(player.playing
                            ? "images/pause.png"
                            : "images/play.png"),
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
