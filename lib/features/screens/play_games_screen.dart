import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/core/widget/common_dialog.dart';
import 'package:flamingo_app/features/screens/choose_pack_screen.dart';
import 'package:flutter/material.dart';

class PlayGamesScreen extends StatelessWidget {
  const PlayGamesScreen({required this.id, required this.packs, super.key});

  final String id;
  final QueryDocumentSnapshot<Map<String, dynamic>> packs;

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
    return PopScope(
      canPop: true,
      // onPopInvoked: (value) {
      //   _onPopInvoked(context, "Warning", "Do you want to quit?", () {
      //     // Navigator.pop(context);
      //   });
      // },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(packs['color']),
          elevation: 0,
          title: Text(
            packs['title'],
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: const Color(0xffffffff),
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
                          _navigateHome(context, "Note",
                              "You have finished your first section", () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChoosePacksScreen()),
                            );
                          });
                        },
                        cardBuilder: (context, index) {
                          final question = questions[index];
                          return Stack(
                            children: [
                              Center(
                                child: Container(
                                  width: 350,
                                  height: 600,
                                  margin: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        // color: Colors.lightBlue, width: 4),
                                        color: Color(packs['color']),
                                        width: 4),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        // child: Image.asset('assets/swipe_icon.png', width: 100, height: 100),
                                        child: Icon(
                                          Icons.swipe,
                                          size: 100,
                                          color: Color(packs['color']),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        // padding: const EdgeInsets.symmetric(
                                        //     horizontal: 16),
                                        child: Text(
                                          "${question['q_title']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(packs['color']),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    // Subscription is now disabled
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const SubscriptionScreen()),
                    //     );
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     padding: const EdgeInsets.symmetric(vertical: 20),
                    //     decoration: const BoxDecoration(
                    //       color: Color(0xFFFF1493),
                    //       borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(20),
                    //         topRight: Radius.circular(20),
                    //       ),
                    //     ),
                    //     child: const Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           'Try all packs!',
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //         SizedBox(width: 10),
                    //         Icon(Icons.keyboard_arrow_up, color: Colors.white),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  _onPopInvoked(
      BuildContext context, String title, String desc, Function() onClick) {
    commonDialog(context, title, desc, onClick);
  }

  _navigateHome(
      BuildContext context, String title, String desc, Function() onClick) {
    commonDialog(context, title, desc, onClick);
  }
}
