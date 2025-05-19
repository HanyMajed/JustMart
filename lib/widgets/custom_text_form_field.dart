import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.textInputType,
    this.suffixIcon,
    this.prefixIcon,
    this.onSaved,
    this.obsecureText = false,
    this.validator,
    this.readOnly = false,
    this.showCursor = true,
    this.readOnlyBackgroundColor = const Color(0xFFEEEEEE), // New
    this.readOnlyTextColor = const Color(0xFF666666), // New
  });
  final String hintText;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String?)? onSaved;
  final bool obsecureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool showCursor;
  final Color readOnlyBackgroundColor;
  final Color readOnlyTextColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      showCursor: showCursor,
      obscureText: obsecureText,
      onSaved: onSaved,
      controller: controller,
      validator: validator ??
          (value) {
            // Modified this line
            if (value == null || value.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },
      style: TextStyle(
        color: readOnly ? readOnlyTextColor : null,
      ),
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyles.bold13.copyWith(color: const Color(0xFF949D9E)),
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Color(0xFFE6E9E9),
      ),
    );
  }
}
