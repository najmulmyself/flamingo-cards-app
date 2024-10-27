import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flamingo_app/features/screens/subsciption_screen.dart';
import 'package:flutter/material.dart';

class PlayGamesScreen extends StatelessWidget {
  const PlayGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A2647),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AppinioSwiper(
                cardCount: 5,
                loop: false,
                allowUnlimitedUnSwipe: false,
                onSwipeEnd: (index, direction, hello) {
                  print("in every swap");
                },
                onEnd: () {
                  print("when cards end");
                },
                // itemWidth: 300,
                // layout: SwiperLayout.STACK,
                cardBuilder: (context, index) {
                  return Stack(
                    children: [
                      // Positioned(
                      //   top: 16,
                      //   left: 16,
                      //   child: Container(
                      //     width: 40,
                      //     height: 20,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white.withOpacity(0.3),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),
                      Center(
                        child: Container(
                          width: 350,
                          height: 600,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: Colors.lightBlue, width: 4),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(40),
                                // child: Image.asset('assets/swipe_icon.png', width: 100, height: 100),
                                child: Icon(
                                  Icons.swipe,
                                  size: 100,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              Text(
                                '#DeepQ',
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );

                  // return Container(
                  //   height: 200,
                  //   width: double.infinity,
                  //   decoration: const BoxDecoration(
                  //     color: Colors.redAccent,
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(10),
                  //     ),
                  //   ),
                  //   child: const ClipRRect(),
                  // );
                },
              ),
            ),
            // Expanded(
            //   child: Stack(
            //     children: [
            //       Positioned(
            //         top: 16,
            //         left: 16,
            //         child: Container(
            //           width: 40,
            //           height: 20,
            //           decoration: BoxDecoration(
            //             color: Colors.white.withOpacity(0.3),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //       ),
            //       Center(
            //         child: Container(
            //           margin: const EdgeInsets.all(16),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(20),
            //             border: Border.all(color: Colors.lightBlue, width: 4),
            //           ),
            //           child: const Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Padding(
            //                 padding: EdgeInsets.all(40),
            //                 // child: Image.asset('assets/swipe_icon.png', width: 100, height: 100),
            //                 child: Icon(
            //                   Icons.swipe,
            //                   size: 100,
            //                   color: Colors.lightBlue,
            //                 ),
            //               ),
            //               Text(
            //                 '#DeepQ',
            //                 style: TextStyle(
            //                     color: Colors.lightBlue,
            //                     fontSize: 24,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //               SizedBox(height: 20),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubscriptionScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF1493),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Try all packs!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.keyboard_arrow_up, color: Colors.white),
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
