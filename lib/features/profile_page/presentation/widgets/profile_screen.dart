import 'package:flutter/material.dart';
import 'package:just_mart/features/auth/signin_view.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/primary_button.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/profile_header.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/profile_settings_list.dart';
import 'package:just_mart/widgets/confirmation_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = "profilescreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  bool _isStudentMode = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'حسابي',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF202124),
            ),
          ),
          centerTitle: true,
          elevation: 1,
          shadowColor: Colors.grey.withOpacity(0.2),
        ),
        body: Column(
          children: [
            const ProfileHeader(
              email: 'mail@mail.com',
              userStatus: 'مستخدم جديد',
            ),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            Expanded(
              child: ProfileSettingsList(
                isDarkMode: _isDarkMode,
                isStudentMode: _isStudentMode,
                onDarkModeChanged: (value) =>
                    setState(() => _isDarkMode = value),
                onStudentModeChanged: (value) =>
                    setState(() => _isStudentMode = value),
              ),
            ),
            PrimaryButton(
              icon: Icons.logout,
              text: 'تسجيل الخروج',
              onPressed: () {
                ConfirmationDialog.show(
                  context: context,
                  title: 'هل ترغب في تسجيل الخروج؟',
                  confirmText: 'نعم',
                  cancelText: 'إلغاء',
                  onConfirm: () {
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    Navigator.of(context)
                        .pushReplacementNamed(SignInView.routeName);
                  },
                  onCancel: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
