import 'package:flutter/material.dart';

class PlayView extends StatelessWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff141616),
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
      backgroundColor: Color(0xff141616),
      body: Column(
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
                  decoration: BoxDecoration(),
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
                color: Color(0x19DEDBDB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 319,
                  height: 52,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: double.infinity,
                        child: Opacity(
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
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        child: Opacity(
                          opacity: 0.70,
                          child: Text(
                            'Kill Bill                     SZA                           2:33',
                            style: TextStyle(
                              color: Color(0xFFF2F2F2),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.07,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/skip-back.png",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44.2),
                child: Image.asset(
                  "images/shuffle.png",
                ),
              ),
              Hero(
                tag: "play",
                child: Container(
                  width: 83.53,
                  height: 81.53,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFB5D2BF), Color(0xFFD5FFE4)],
                    ),
                    shape: OvalBorder(),
                  ),
                  child: Center(child: Image.asset("images/pause.png"),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44.2),
                child: Image.asset(
                  "images/skip-forward.png",
                ),
              ),
              Image.asset(
                "images/repeat.png",
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
