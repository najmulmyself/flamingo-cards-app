import 'package:flamingo_app/core/theme/app_palate.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        color: AppPallete.backgroundColor,
      ),
      child: const Text('Home Screen'),
    ));
  }
}
