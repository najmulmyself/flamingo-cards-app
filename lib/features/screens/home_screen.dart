import 'package:flamingo_app/const/app_constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: const CommonAppBar(
        //   title: "Choose your date",
        // ),
        body: Padding(
          padding: AppConstant.screenPadding,
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Center(child: Text('Home Screen')),
              ),
            ],
          ),
        ));
  }
}
