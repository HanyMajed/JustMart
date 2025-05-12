import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});
  static const String routeName = "AddProduct";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "AddProduct",
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
