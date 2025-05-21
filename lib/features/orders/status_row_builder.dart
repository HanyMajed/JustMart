import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

class RowBuilder extends StatelessWidget {
  RowBuilder({super.key, required this.isColored, required this.icon, required this.text});
  IconData icon;
  String text;
  bool isColored;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isColored ? Colors.grey.shade400 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(51, 69, 94, 114),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    icon,
                    color: AppColors.primaryColor,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyles.bold16.copyWith(color: Colors.grey.shade800),
              ),
            ]),
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
