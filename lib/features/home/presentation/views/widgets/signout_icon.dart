import 'package:flutter/material.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: const ShapeDecoration(shape: OvalBorder(), color: Color.fromRGBO(31, 61, 120, 0.2) // 50% transparent
            ),
        child: const Icon(Icons.logout_outlined),
      ),
    );
  }
}
