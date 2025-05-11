import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';

import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/auth/presentation/views/signup_view.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'لا تمتلك حساب؟',
            style: TextStyles.semiBold16.copyWith(
              color: const Color(0xFF616A6B),
            ),
          ),
          TextSpan(
            text: ' ',
            style: TextStyles.semiBold16.copyWith(
              color: const Color(0xFF616A6B),
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, SignupView.routeName);
              },
            text: 'قم بانشاء حساب',
            style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
