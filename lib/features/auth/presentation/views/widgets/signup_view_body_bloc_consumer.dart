import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/helper_functions/build_error_bar.dart';
import 'package:just_mart/features/auth/data/repos/cubits/SignUp_cubit.dart/signup_cubit.dart';
import 'package:just_mart/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpViewBodyBlocConsumer extends StatelessWidget {
  const SignUpViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSucess) {
          Navigator.of(context).pop();
        }
        if (state is SignupFailure) {
          BuildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading ? true : false,
          child: const SignupViewBody(),
        );
      },
    );
  }
}
