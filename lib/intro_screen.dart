import 'package:demos_app/home.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // padding: EdgeInsets.symmetric(horizontal: 10),
      // width: 428,
      // height: 926,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFF141616)),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 428,
              height: 723,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/img.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 220,
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
          Positioned(
            // left: 30,
            top: 453,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 368,
                        child: Text(
                          'Exclusive Music Collection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Find all the recent and the best exclusive music that you can find only on Phones and  no other',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.800000011920929),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          // fontWeight: FontWeight.w400,
                          // height: 24,
                          // letterSpacing: 0.08,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 46),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 35,
                          height: 9,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD5FFE4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 9,
                          height: 9,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF3F4545),
                            shape: OvalBorder(),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 9,
                          height: 9,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF3F4545),
                            shape: OvalBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 46),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const HomeView())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD4FFE4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Start',
                          style: TextStyle(
                            color: Color(0xFF141616),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
