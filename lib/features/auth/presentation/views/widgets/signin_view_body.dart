import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/constants.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/auth/data/repos/cubits/signin_cubit/signin_cubit.dart';
import 'package:just_mart/widgets/custom_button.dart';
import 'package:just_mart/widgets/custom_text_form_field.dart';
import 'package:just_mart/widgets/donthave_account.dart';
import 'package:just_mart/widgets/password_field.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});
  static const String routeName = 'LoginViewBody';

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  late String email, password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizantalPadding),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                hintText: 'البريد الإلكتروني',
              ),
              const SizedBox(
                height: 24,
              ),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'نسيت كلمة المرور؟',
                    style: TextStyles.semiBold13.copyWith(color: AppColors.lightprimaryColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 33,
              ),
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<SigninCubit>().signin(email, password);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  text: 'تسجيل دخول'),
              const SizedBox(
                height: 33,
              ),
              const DontHaveAccountWidget(),
              const SizedBox(
                height: 33,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
