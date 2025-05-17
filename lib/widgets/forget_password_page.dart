import 'package:flutter/material.dart';
import 'package:just_mart/core/errors/exceptions.dart';
import 'package:just_mart/core/services/firebase_auth_service.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/widgets/custom_appbar.dart';
import 'package:just_mart/widgets/custom_button.dart';
import 'package:just_mart/widgets/custom_text_form_field.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});
  static const routeName = 'forgetpasswordpage';

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuthService().sendPasswordResetEmail(
        _emailController.text.trim(),
      );

      if (!mounted) return;
      _showSuccessMessage();
      Navigator.pop(context);
    } on CustomException catch (e) {
      if (!mounted) return;
      _showErrorMessage(e.message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'إعادة تعيين كلمة المرور'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ادخل بريدك الإلكتروني لإرسال رابط إعادة تعيين كلمة المرور',
                style:
                    TextStyles.bold13.copyWith(color: AppColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _emailController,
                validator: _validateEmail,
                hintText: 'البريد الإلكتروني',
                suffixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: _resetPassword,
                text: _isLoading ? 'جاري الإرسال...' : 'إرسال الرابط',
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }
    if (!RegExp(r'^[\w\.-]+@[\w-]+\.just\.edu\.jo$').hasMatch(value)) {
      return 'البريد الإلكتروني يجب أن ينتهي بـ YourCollege.just.edu.jo@';
    }
    return null;
  }
}
