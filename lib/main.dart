import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:demos_app/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool selectedItem = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // padding: EdgeInsets.symmetric(horizontal: 10),
      width: 428,
      height: 926,
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
                      SizedBox(
                        width: 368,
                        child: Text(
                          'Find all the recent and the best exclusive music that you can find only on Phnes and  no other',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.800000011920929),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            // fontWeight: FontWeight.w400,
                            // height: 24,
                            // letterSpacing: 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 46),
                  Row(
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
                  const SizedBox(height: 46),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 368,
                            height: 60,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2A2E2E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeView())),
                              child: Container(
                                // width: 130,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD4FFE4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Start',
                                        style: TextStyle(
                                          color: Color(0xFF141616),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 48,
                            height: 24,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 24,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..translate(0.0, 0.0)
                                      ..rotateZ(-1.57),
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Stack(children: const []),
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   left: 12,
                                //   top: 24,
                                //   child: Transform(
                                //     transform: Matrix4.identity()
                                //       ..translate(0.0, 0.0)
                                //       ..rotateZ(-1.57),
                                //     child: SizedBox(
                                //       width: 24,
                                //       height: 24,
                                //       child: Stack(children: const []),
                                //     ),
                                //   ),
                                // ),
                                // Positioned(
                                //   left: 24,
                                //   top: 24,
                                //   child: Transform(
                                //     transform: Matrix4.identity()
                                //       ..translate(0.0, 0.0)
                                //       ..rotateZ(-1.57),
                                //     child: SizedBox(
                                //       width: 24,
                                //       height: 24,
                                //       child: Stack(children: const []),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 418,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  Positioned(
                    left: 336.67,
                    top: 8,
                    child: SizedBox(
                      width: 66.66,
                      height: 20.67,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 42.33,
                            top: 9.33,
                            child: SizedBox(
                              width: 24.33,
                              height: 11.33,
                              child: Stack(children: const []),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 903,
            child: SizedBox(
              width: 428,
              height: 23,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 414,
                    height: 34,
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 134,
                      right: 134,
                      bottom: 19,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 146,
                          height: 5,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ],
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

class SelectCoursesBotomSheet extends StatefulWidget {
  const SelectCoursesBotomSheet({super.key});

  @override
  State<SelectCoursesBotomSheet> createState() =>
      _SelectCoursesBotomSheetState();
}

class _SelectCoursesBotomSheetState extends State<SelectCoursesBotomSheet> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          const Text("ouserse"),
          Column(
            children: couses
                .map((e) => ListTile(
                      onTap: () {
                        setState(() {
                          selectedItem = e;
                        });
                      },
                      leading: Icon(selectedItem == e
                          ? Icons.check_circle_outlined
                          : Icons.circle_outlined),
                      title: Text(e),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

List couses = ["Habitfjkdfjkkjdf", "kjsdnfjkdsf", "kjsdkjsd"];
