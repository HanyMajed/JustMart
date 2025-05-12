import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';

class VendorTransitionChoices extends StatelessWidget {
  const VendorTransitionChoices({
    super.key,
    required this.choice,
  });
  final String choice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.primaryColor,
          ),
          width: double.infinity,
          height: 60,
          child: Center(
              child: Text(
            choice,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
