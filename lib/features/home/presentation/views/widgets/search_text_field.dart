import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            spreadRadius: 0,
            blurRadius: 9,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: SizedBox(width: 20, child: Center(child: SvgPicture.asset(Assets.assetsImagesSearchNormal))),
          suffixIcon: SizedBox(width: 20, child: Center(child: SvgPicture.asset(Assets.assetsImagesFiltter))),
          hintText: 'ابحث عن.......',
          hintStyle: TextStyles.regular13.copyWith(
            color: const Color(0xFF949D9E),
          ),
          filled: true,
          fillColor: Colors.white,
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Colors.white,
      ),
    );
  }
}
