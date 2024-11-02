// import 'package:flamingo_app/core/theme/app_palate.dart';
// import 'package:flutter/material.dart';

// class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CommonAppBar({
//     required this.title,
//     super.key,
//   });

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(title),
//       centerTitle: true,
//       backgroundColor: AppPallete.primaryColor,
//       elevation: 0,
//       leading: IconButton(
//         onPressed: () {},
//         icon: const Icon(Icons.menu),
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.settings),
//         ),
//       ],
//     );
//   }

//     @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';

class CommonSliverAppBar extends StatelessWidget {
  const CommonSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      floating: true,
      backgroundColor: Color(0xffffffff),
      title: Text(
        "Pair Play",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      leading: Icon(Icons.settings),
    );
  }
}
