import 'package:flutter/material.dart';
import 'package:just_mart/features/splash/presentation/views/widgets/onboardingview_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  static const String routeName = 'OnBoardingView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: OnBoardingViewBody()));
  }
}
