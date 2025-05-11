import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

AppBar customAppBar(context, {required String title}) {
  return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new)),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.bold19,
      ));
}
