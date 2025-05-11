import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'تمتلك حساب بالفعل؟',
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
                Navigator.pop(context);
              },
            text: 'تسجيل دخول',
            style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
