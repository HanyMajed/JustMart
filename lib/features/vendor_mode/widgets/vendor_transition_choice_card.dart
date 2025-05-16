import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';

class VendorTransitionChoice extends StatelessWidget {
  const VendorTransitionChoice({
    super.key,
    required this.choice,
    required this.signedUID,
    required this.icon,
  });
  final String signedUID;
  final String choice;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color.fromARGB(148, 158, 158, 158), width: 1)),
        ),
        width: double.infinity,
        height: 32,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                choice,
                style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 102, 102, 102)),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_left,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
