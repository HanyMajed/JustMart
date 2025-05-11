import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/services/get_it_service.dart';
import 'package:just_mart/features/auth/data/domain/repos/auth_repo.dart';
import 'package:just_mart/features/auth/data/repos/cubits/SignUp_cubit.dart/signup_cubit.dart';
import 'package:just_mart/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart';
import 'package:just_mart/widgets/custom_appbar.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const String routeName = 'SignupView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(authRepo: getIt<AuthRepo>()),
      child: Scaffold(
        appBar: customAppBar(context, title: 'حساب جديد'),
        body: const SignUpViewBodyBlocConsumer(),
      ),
    );
  }
}
