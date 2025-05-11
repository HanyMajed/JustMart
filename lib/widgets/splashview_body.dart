import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_mart/constants.dart';
import 'package:just_mart/core/services/shared_prefrences_singleton.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/features/auth/signin_view.dart';
import 'package:just_mart/features/splash/presentation/views/on_boarding/presentation/views/on_boarding.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    excuteNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [SvgPicture.asset(Assets.assetsImagesPlant)]),
        SvgPicture.asset(Assets.assetsImagesLogo),
        SvgPicture.asset(Assets.assetsImagesSplashBottom, fit: BoxFit.fill),
      ],
    );
  }

  void excuteNavigation() {
    bool isOnBoardingSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    Future.delayed(const Duration(seconds: 3), () {
      if (isOnBoardingSeen) {
        Navigator.pushReplacementNamed(context, SignInView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }
}
