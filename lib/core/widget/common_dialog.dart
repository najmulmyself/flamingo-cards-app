import 'package:flutter/material.dart';

Future<dynamic> commonDialog(
    BuildContext context, String title, String desc, Function() onClick) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(desc),
        actions: <Widget>[
          TextButton(onPressed: onClick, child: const Text("Okay")),
        ],
      );
    },
  );
}
