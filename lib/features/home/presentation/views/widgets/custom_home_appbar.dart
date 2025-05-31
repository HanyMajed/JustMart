import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/Notification_widget.dart';
import 'package:just_mart/features/home/presentation/views/widgets/signout_icon.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/profile_screen.dart';
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
        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingAppBar();
        }

        // Handle error state
        if (snapshot.hasError || !snapshot.hasData) {
          return _buildErrorAppBar();
        }

        final data = snapshot.data!;
        final name = data['name'] ?? 'مستخدم جديد';
        isVendor = data['role'] == 'vendor'; // Safe access after null check

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          trailing: isVendor
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    VendorIconWidget(signedUID: signedUID),
                    const SizedBox(width: 5),
                    //   const NotificationWidget(),
                    const SizedBox(width: 5),
                    const SignOutWidget(),
                  ],
                )
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //  NotificationWidget(),
                    SizedBox(width: 5),
                    SignOutWidget(),
                  ],
                ),
          leading: _buildPressableProfilePhoto(context),
          title: Text(
            'مرحبا بك',
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

  Widget _buildPressableProfilePhoto(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProfileScreen.routeName, arguments: signedUID);
      },
      child: Image.asset(Assets.assetsImagesProfilePhotoIcon),
    );
  }

  Widget _buildLoadingAppBar() {
    return ListTile(
      leading: Image.asset(Assets.assetsImagesProfilePhotoIcon),
      title: Text(
        'جاري التحميل...',
        style: TextStyles.regular16.copyWith(color: const Color(0xFF949D9E)),
      ),
    );
  }

  Widget _buildErrorAppBar() {
    return ListTile(
      leading: Image.asset(Assets.assetsImagesProfilePhotoIcon),
      title: Text(
        'مرحبا بك',
        style: TextStyles.regular16.copyWith(color: const Color(0xFF949D9E)),
      ),
      subtitle: const Text(
        'مستخدم جديد',
        style: TextStyles.bold16,
      ),
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
