import 'package:flutter/material.dart';
import 'package:just_mart/features/auth/signin_view.dart';
import 'package:just_mart/features/auth/presentation/views/signup_view.dart';
import 'package:just_mart/features/splash/presentation/views/on_boarding/presentation/views/on_boarding.dart';
import 'package:just_mart/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());

    case SignInView.routeName:
      return MaterialPageRoute(builder: (context) => const SignInView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
