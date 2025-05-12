import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/Notification_widget.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({super.key, required this.signedUID});
  final String signedUID;

  Future<Map<String, dynamic>> _fetchUserData() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(signedUID).get();
      return doc.data() ?? {};
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        final userName = snapshot.hasData
            ? snapshot.data!['name'] ?? 'مستخدم جديد ' // Fallback name
            : 'مستخدم جديد';

        final welcomeText = snapshot.connectionState == ConnectionState.waiting ? 'جاري التحميل...' : 'مرحبا بك';

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          trailing: const NotificationWidget(),
          leading: Image.asset(Assets.assetsImagesProfilePhotoIcon),
          title: Text(
            welcomeText,
            textAlign: TextAlign.right,
            style: TextStyles.regular16.copyWith(
              color: const Color(0xFF949D9E),
            ),
          ),
          subtitle: Text(
            userName,
            textAlign: TextAlign.right,
            style: TextStyles.bold16,
          ),
        );
      },
    );
  }
}
