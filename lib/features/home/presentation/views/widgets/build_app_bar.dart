import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/Notification_widget.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    actions: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: NotificationWidget(),
      )
    ],
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: const Text(
      ' الأكثر مبيعا',
      textAlign: TextAlign.center,
      style: TextStyles.bold19,
    ),
  );
}
