import 'package:demos_app/player_view.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final player = AudioPlayer();
  @override
  void initState() {
    // playAudio();
    // TODO: implement initState
    super.initState();
  }

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
              child: Container(
                width: 686,
                height: 386,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/img1.png"),
                    fit: BoxFit.fill,
                  ),
                ),
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
                    Container(
                      height: 124,
                      // color: Colors.blue,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              // color: Colors.yellow,
                              child: Column(
                                // mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 60,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Text(
                                          'Lonely mixn',
                                          style: TextStyle(
                                            color: Color(0xFFD5FFE4),
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 19),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      OpacityCards(
                                        image: "images/fav.png",
                                      ),
                                      // const SizedBox(width: 10),
                                      SizedBox(width: 16),

                                      OpacityCards(
                                        image: "images/sys.png",
                                      ),
                                      SizedBox(width: 16),
                                      OpacityCards(
                                        image: "images/add.png",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //
                          //
                          // const SizedBox(width: 109),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const PlayView())),
                            child: Hero(
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
                                child: Center(
                                    child: Image.asset("images/play.png")),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                        Container(
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
                            'See all',
                            style: TextStyle(
                              color:
                                  Colors.white.withOpacity(0.8999999761581421),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(

                        // color: Colors.red,
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: ListView.builder(
                          itemCount: playList.length,
                          itemBuilder: (context, index) => NewReleaseCompnent(
                            title: playList[index]['title'],
                            subTitle: playList[index]['subtitle'],
                            imageTitle: playList[index]['image'],
                          ),
                        ))
                    ////////////////////////
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

class NewReleaseCompnent extends StatelessWidget {
  const NewReleaseCompnent({
    super.key,
    this.title,
    this.subTitle,
    this.imageTitle,
  });
  final String? title;
  final String? subTitle;
  final String? imageTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(imageTitle!),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subTitle!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.699999988079071),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const Text(
                  "....",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OpacityCards extends StatelessWidget {
  const OpacityCards({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.60,
      child: Container(
        width: 45,
        height: 45,
        decoration: ShapeDecoration(
          color: const Color(0xFF2A2E2E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Center(
          child: Image.asset(image),
        ),
      ),
    );
  }
}

List playList = [
  {
    "image": "images/mag1.png",
    "title": "Guitar Songs",
    "subtitle": "Billie Eilish"
  },
  {
    "image": "images/mag2.png",
    "title": "No Dey Farm",
    "subtitle": "Babyboy AV"
  },
  {
    "image": "images/mag3.png",
    "title": "Maria",
    "subtitle": "Hwa Sa",
  },
  {
    "image": "images/mag4.png",
    "title": "King",
    "subtitle": "Prom",
  },
];
