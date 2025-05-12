import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/Notification_widget.dart';
import 'package:just_mart/features/home/presentation/views/widgets/signout_icon.dart';
import 'package:just_mart/features/vendor_mode/widgets/vendor_icon_widget.dart';

class CustomHomeAppbar extends StatelessWidget {
  CustomHomeAppbar({super.key, required this.signedUID});
  final String signedUID;
  bool isVendor = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        final name = snapshot.hasData
            ? snapshot.data!['name'] ?? 'مستخدم جديد ' // Fallback name
            : 'مستخدم جديد';
        if (snapshot.data!['role'] == 'vendor') {
          isVendor = true;
        }

        final welcomeText = snapshot.connectionState == ConnectionState.waiting ? 'جاري التحميل...' : 'مرحبا بك';

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          trailing: isVendor
              ? const Row(
                  mainAxisSize: MainAxisSize.min, // Important to prevent overflow
                  children: [
                    VendorIconWidget(),
                    SizedBox(
                      width: 5,
                    ),
                    NotificationWidget(),
                    SizedBox(
                      width: 5,
                    ),
                    // Your existing notification
                    SignOutWidget(),
                  ],
                )
              // ignore: prefer_const_constructors
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NotificationWidget(),
                    SizedBox(
                      width: 5,
                    ),
                    SignOutWidget(),
                  ],
                ), //
          leading: Image.asset(Assets.assetsImagesProfilePhotoIcon),
          title: Text(
            welcomeText,
            textAlign: TextAlign.right,
            style: TextStyles.regular16.copyWith(
              color: const Color(0xFF949D9E),
            ),
          ),
          subtitle: Text(
            name,
            textAlign: TextAlign.right,
            style: TextStyles.bold16,
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(signedUID).get();
      return doc.data() ?? {};
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return {};
    }
  }
}
