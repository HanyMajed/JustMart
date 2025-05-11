import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/services/get_it_service.dart';
import 'package:just_mart/features/auth/data/domain/repos/auth_repo.dart';
import 'package:just_mart/features/auth/data/repos/cubits/signin_cubit/signin_cubit.dart';
import 'package:just_mart/widgets/custom_appbar.dart';
import 'package:just_mart/widgets/signin_view_body_bloc_consumer.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  static const String routeName = 'LoginView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: customAppBar(context, title: 'تسجيل دخول'),
        body: const SignInViewBodyBlocConsumer(),
      ),
    );
  }
}
