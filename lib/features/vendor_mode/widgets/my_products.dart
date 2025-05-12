import 'package:flutter/material.dart';

class MyProducts extends StatelessWidget {
  const MyProducts({super.key});
  static const String routeName = "MyProducts";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        "MyProducts",
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
