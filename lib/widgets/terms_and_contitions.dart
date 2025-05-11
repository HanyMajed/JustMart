import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/widgets/custom_checkbox.dart';

class TermsAndContitions extends StatefulWidget {
  const TermsAndContitions({super.key, required this.onChanged});
  final ValueChanged<bool> onChanged;

  @override
  State<TermsAndContitions> createState() => _TermsAndContitionsState();
}

class _TermsAndContitionsState extends State<TermsAndContitions> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 0),
      child: Row(
        children: [
          CustomCheckbox(
            isChecked: isTermsAccepted,
            onChanged: (value) {
              isTermsAccepted = value;
              widget.onChanged(value);
              setState(() {});
            },
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'من خلال إنشاء حساب ، فإنك توافق على',
                    style: TextStyles.semiBold13.copyWith(
                      color: const Color(0xFF949D9E),
                    ),
                  ),
                  TextSpan(
                    text: ' الشروط والأحكام الخاصة بنا',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.lightprimaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyles.semiBold13.copyWith(),
                  ),
                  TextSpan(
                    text: 'الخاصة',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.lightprimaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ' بنا',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.lightprimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
