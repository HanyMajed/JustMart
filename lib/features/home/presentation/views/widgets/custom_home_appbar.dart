import 'package:flutter/material.dart';

import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/Notification_widget.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      trailing: const NotificationWidget(),
      leading: Image.asset(Assets.assetsImagesProfilePhotoIcon),
      title: Text(
        'صباح الخير !..',
        textAlign: TextAlign.right,
        style: TextStyles.regular16.copyWith(
          color: const Color(0xFF949D9E),
        ),
      ),
      subtitle: const Text(
        'أحمد مصطفي',
        textAlign: TextAlign.right,
        style: TextStyles.bold16,
      ),
    );
  }
}
