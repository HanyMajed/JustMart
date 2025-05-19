import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

AppBar appbarForVendorViews({required String title}) {
  return AppBar(
    iconTheme: const IconThemeData(
      color: Colors.black, // Change this to your desired color
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyles.bold19.copyWith(color: Colors.black),
    ),
  );
}
