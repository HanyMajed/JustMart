import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_images.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({super.key, required this.isChecked, required this.onChanged});
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked);
      },
      child: AnimatedContainer(
        width: 24,
        height: 24,
        duration: const Duration(milliseconds: 150),
        decoration: ShapeDecoration(
          color: isChecked ? AppColors.primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.50, color: isChecked ? AppColors.primaryColor : const Color(0xFFDCDEDE)),
            borderRadius: BorderRadius.circular(8),
          ),
          // RoundedRectangleBorder
        ),
        child: isChecked
            ? Padding(
                padding: const EdgeInsets.all(3.0),
                child: SvgPicture.asset(
                  Assets.assetsImagesVector,
                ),
              )
            : null, // ShapeDecoration
      ),
    );
  }
}
