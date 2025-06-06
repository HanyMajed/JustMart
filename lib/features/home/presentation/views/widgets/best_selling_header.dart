import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

class SellingHeader extends StatelessWidget {
  SellingHeader({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyles.bold16,
      ),
    );
  }
}
