import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/constants.dart';
import 'package:just_mart/core/helper_functions/build_error_bar.dart';
import 'package:just_mart/features/auth/data/repos/cubits/SignUp_cubit.dart/signup_cubit.dart';
import 'package:just_mart/widgets/custom_button.dart';
import 'package:just_mart/widgets/custom_text_form_field.dart';
import 'package:just_mart/widgets/have_an_account.dart';
import 'package:just_mart/widgets/password_field.dart';
import 'package:just_mart/widgets/terms_and_contitions.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, username, password, phoneNumber;
  late bool isTermsAccepted = false;
  String selectedRole = 'buyer';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizantalPadding),
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
                  username = value!;
                },
                textInputType: TextInputType.visiblePassword,
                hintText: 'الاسم كامل',
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                textInputType: TextInputType.visiblePassword,
                hintText: 'البريد الإلكتروني',
              ),
              const SizedBox(
                height: 16,
              ),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  phoneNumber = value!;
                },
                textInputType: TextInputType.visiblePassword,
                hintText: 'رقم الهاتف',
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('مشتري'),
                      value: 'buyer',
                      groupValue: selectedRole,
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('بائع'),
                      value: 'vendor',
                      groupValue: selectedRole,
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              TermsAndContitions(
                onChanged: (value) {
                  isTermsAccepted = value;
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (isTermsAccepted) {
                        context.read<SignupCubit>().createUserWithEmailAndPassword(
                              email,
                              password,
                              username,
                              selectedRole,
                              phoneNumber,
                            );
                      } else {
                        BuildErrorBar(context, "يجب الموافقة على الشروط والاحكام");
                      }
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  text: 'إنشاء حساب جديد'),
              const SizedBox(
                height: 26,
              ),
              const HaveAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
