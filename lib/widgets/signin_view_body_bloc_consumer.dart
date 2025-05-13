import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/helper_functions/build_error_bar.dart';
import 'package:just_mart/features/auth/data/repos/cubits/signin_cubit/signin_cubit.dart';
import 'package:just_mart/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:just_mart/features/home/presentation/views/home_view.dart';
import 'package:just_mart/features/splash/presentation/views/widgets/custom_progress_hud.dart';

class SignInViewBodyBlocConsumer extends StatelessWidget {
  const SignInViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSucess) {
          // log(state.userEntity.name);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HomeView(
                signedUID: state.userEntity.uId,
              );
            },
          ));
          //   Navigator.pushReplacementNamed(context, HomeView.routeName, arguments: {'signedUID': state.userEntity.uId});
        }
        if (state is SigninFailure) {
          BuildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SigninLoading ? true : false,
          child: const SignInViewBody(),
        );
      },
    );
  }
}
