import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});
  static const String routeName = "MyOrders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "MyOrders",
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
