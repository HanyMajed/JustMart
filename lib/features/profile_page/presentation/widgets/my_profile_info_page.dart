import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_mart/core/errors/exceptions.dart';
import 'package:just_mart/core/services/firebase_auth_service.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/widgets/custom_button.dart';
import 'package:just_mart/widgets/custom_text_form_field.dart';

class MyProfileInfoPage extends StatefulWidget {
  const MyProfileInfoPage({super.key});
  static const routeName = 'myProfileinfopage';

  @override
  State<MyProfileInfoPage> createState() => _MyProfileInfoPageState();
}

class _MyProfileInfoPageState extends State<MyProfileInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = true;
  bool _isResettingPassword = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        setState(() {
          _nameController.text = doc['name'] ?? 'مستخدم جديد';
          _emailController.text = user.email ?? 'mail@mail.com';
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resetPassword() async {
    setState(() => _isResettingPassword = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) {
        throw CustomException(message: 'يجب تسجيل الدخول أولاً');
      }

      await FirebaseAuthService().sendPasswordResetEmail(user.email!);

      if (!mounted) return;
      _showSuccessMessage();
    } on CustomException catch (e) {
      if (!mounted) return;
      _showErrorMessage(e.message);
    } catch (e) {
      if (!mounted) return;
      _showErrorMessage('حدث خطأ غير متوقع');
    } finally {
      if (mounted) setState(() => _isResettingPassword = false);
    }
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني',
          style: TextStyles.regular13.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.lightprimaryColor,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('خطأ', style: TextStyles.bold16),
        content: Text(message, style: TextStyles.regular13),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً', style: TextStyles.bold13),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'الملف الشخصي',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 135, 136, 141),
            ),
          ),
          centerTitle: true,
          elevation: 1,
          shadowColor: Colors.grey.withOpacity(0.2),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'المعلومات الشخصية',
                          style: TextStyles.bold13,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _nameController,
                        hintText: 'الاسم',
                        textInputType: TextInputType.name,
                        readOnly: true,
                        showCursor: false,
                        readOnlyBackgroundColor: const Color(0xFFF5F5F5),
                        readOnlyTextColor: const Color(0xFF757575),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'البريد الإلكتروني',
                        textInputType: TextInputType.emailAddress,
                        readOnly: true,
                        showCursor: false,
                        readOnlyBackgroundColor: const Color(0xFFF5F5F5),
                        readOnlyTextColor: const Color(0xFF757575),
                      ),
                      const SizedBox(height: 32),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'تغيير كلمة المرور',
                          style: TextStyles.bold13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'لإعادة تعيين كلمة المرور، سيتم إرسال رابط إلى بريدك الإلكتروني المسجل',
                        style: TextStyles.regular13
                            .copyWith(color: AppColors.primaryColor),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        onPressed: _resetPassword,
                        text: _isResettingPassword
                            ? 'جاري الإرسال...'
                            : 'إرسال رابط التغيير',
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        text: 'حفظ التغييرات',
                        onPressed: () {
                          // Optional: Handle other save logic
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
