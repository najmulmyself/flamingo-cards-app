import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/core/widget/common_appbar.dart';
import 'package:flamingo_app/features/screens/play_games_screen.dart';
import 'package:flutter/material.dart';

class ChoosePacksScreen extends StatelessWidget {
  const ChoosePacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
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

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final pack = packs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PlayGamesScreen(
                                        packs: pack,
                                            id: pack.id,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PackCard(
                                title: pack['title'] ?? "No Title",
                                description: pack['desc'] ?? "No Description",
                                color: Color(pack['color'] ?? Colors.redAccent),
                                icon: pack['icon'] ?? '👥',
                              ),
                            ),
                          );
                        },
                        childCount: packs.length,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

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
