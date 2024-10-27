import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/core/widget/common_appbar.dart';
import 'package:flamingo_app/features/screens/play_games_screen.dart';
import 'package:flutter/material.dart';

class ChoosePacksScreen extends StatelessWidget {
  const ChoosePacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A2647),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const CommonSliverAppBar(),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('party-category')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Center(
                            child: Text(
                          'No packs available',
                          style: TextStyle(color: Colors.white),
                        )),
                      );
                    }

                    final packs = snapshot.data!.docs;
                    print("packs: ${packs.first.id}");

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final pack = packs[index];
                          return GestureDetector(
                            onTap: () {
                              // print(pack);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>  PlayGamesScreen(id: pack.id,)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PackCard(
                                title: pack['title'] ?? "No Title",
                                description: pack['desc'] ?? "No Description",
                                color: const Color(0xFF5FBDFF),
                                icon: '👥',
                              ),
                            ),
                          );
                        },
                        childCount: packs.length,
                      ),

                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (_) => const PlayGamesScreen()));
                      //   },
                      //   child: const PackCard(
                      //     title: 'Getting Closer',
                      //     description:
                      //         'Say goodbye to basic small talks and embrace meaningful conversations',
                      //     color: Color(0xFF5FBDFF),
                      //     icon: '👥',
                      //   ),
                      // ),
                      // const SizedBox(height: 16),
                      // const PackCard(
                      //   title: 'Hot & Spicy',
                      //   description:
                      //       'Turn up the heat, explore secret fantasies, and ignite the passion',
                      //   color: Color(0xFFFF69B4),
                      //   icon: '🔥',
                      // ),
                      // const SizedBox(height: 16),
                      // const PackCard(
                      //   title: 'Love Talks',
                      //   description:
                      //       'Your guide to a happier relationship - speak truth, share past and future plans',
                      //   color: Color(0xFFFF69B4),
                      //   icon: '❤️',
                      // ),
                      // const SizedBox(height: 16),
                      // const PackCard(
                      //   title: 'Deep Dive!',
                      //   description:
                      //       'Deep conversation topics to get you thinking and talking!',
                      //   color: Color(0xFF4169E1),
                      //   icon: '🤔',
                      // ),
                      // const SizedBox(height: 16),
                      // const PackCard(
                      //   title: 'Would you rather',
                      //   description:
                      //       'Dive into fun dilemmas - good luck making those choices!',
                      //   color: Color(0xFF8A2BE2),
                      //   icon: '🤷',
                      // ),
                      // ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// class CommonSliverAppBar extends StatelessWidget {
//   const CommonSliverAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SliverAppBar(
//       floating: true,
//       backgroundColor: Color(0xFF0A2647),
//       title: Text(
//         'Choose packs',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//       leading: Icon(Icons.settings),
//       actions: [Icon(Icons.info_outline)],
//     );
//   }
// }

class PackCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final String icon;

  const PackCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Text(
              icon,
              style: const TextStyle(fontSize: 80),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
