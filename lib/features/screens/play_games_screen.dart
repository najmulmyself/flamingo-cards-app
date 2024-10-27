import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/features/screens/subsciption_screen.dart';
import 'package:flutter/material.dart';

class PlayGamesScreen extends StatelessWidget {
  const PlayGamesScreen({required this.id, super.key});

  final String id;

  Future<List<Map<String, dynamic>>> fetchQuestions() async {
    final questionsSnapshot = await FirebaseFirestore.instance
        .collection('party-category')
        .doc(id)
        .collection('questions')
        .get();

    return questionsSnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A2647),
      body: SafeArea(
        child: FutureBuilder(
            future: fetchQuestions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  "Error loading questions",
                  style: TextStyle(color: Colors.white),
                ));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("No questions available",
                        style: TextStyle(
                          color: Colors.white,
                        )));
              }

              final questions = snapshot.data!;

              return Column(
                children: [
                  Expanded(
                    child: AppinioSwiper(
                      cardCount: questions.length,
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
                        final question = questions[index];
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
                                  border: Border.all(
                                      color: Colors.lightBlue, width: 4),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(40),
                                      // child: Image.asset('assets/swipe_icon.png', width: 100, height: 100),
                                      child: Icon(
                                        Icons.swipe,
                                        size: 100,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    Text(
                                      // '#DeepQ',
                                      "${question['q_title']}",
                                      style: const TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 20),
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
              );
            }),
      ),
    );
  }
}
