import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/widgets/custom_text_form_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
  });
  final void Function(String?)? onSaved;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      obsecureText: obsecureText,
      onSaved: (value) {
        widget.onSaved!(value);
      },
      textInputType: TextInputType.visiblePassword,
      suffixIcon: GestureDetector(
        onTap: () {
          obsecureText = !obsecureText;
          setState(() {});
        },
        child: obsecureText
            ? const Icon(
                Icons.visibility,
                color: Color.fromARGB(130, 58, 90, 153),
              )
            : const Icon(
                Icons.visibility_off,
                color: Color.fromARGB(130, 58, 90, 153),
              ),
      ),
      hintText: 'كلمة المرور',
    );
  }
}
