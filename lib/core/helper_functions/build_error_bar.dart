import 'package:flutter/material.dart';

void BuildErrorBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromARGB(255, 70, 12, 8),
      content: Text(message),
    ),
  );
}
