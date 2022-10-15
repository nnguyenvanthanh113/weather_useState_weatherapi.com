import 'package:flutter/material.dart';

Widget? errorLogin(BuildContext context, Widget? child, @required error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        error.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
