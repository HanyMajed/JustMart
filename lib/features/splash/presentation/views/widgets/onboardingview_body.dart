import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/constants.dart';
import 'package:just_mart/core/services/shared_prefrences_singleton.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/features/auth/signin_view.dart';
import 'package:just_mart/features/splash/presentation/views/widgets/onboarding_pageview.dart';
import 'package:just_mart/widgets/custom_button.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: OnboardingPageview(
          pageController: pageController,
        )),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            activeColor: AppColors.primaryColor,
            color: currentPage == 1 ? AppColors.primaryColor : const Color.fromARGB(127, 31, 94, 59),
          ),
        ),
        const SizedBox(height: 29),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: currentPage == 1 ? true : false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizantalPadding),
            child: CustomButton(
                onPressed: () {
                  Prefs.setBool(kIsOnBoardingViewSeen, true);
                  Navigator.of(context).pushReplacementNamed(SignInView.routeName);
                },
                text: 'ابدأ الان'),
          ),
        ),
        const SizedBox(height: 43),
      ],
    );
  }
}
