import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_mart/constants.dart';
import 'package:just_mart/core/services/shared_prefrences_singleton.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/auth/signin_view.dart';

class PageVIewItem extends StatelessWidget {
  const PageVIewItem({
    super.key,
    required this.image,
    required this.backgroungImage,
    required this.subTitle,
    required this.title,
    required this.isVisible,
  });

  final String image, backgroungImage;
  final String subTitle;
  final Widget title;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(backgroungImage, fit: BoxFit.fill),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    image,
                    fit: BoxFit.contain,
                    height: 400,
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: GestureDetector(
                    onTap: () {
                      Prefs.setBool(kIsOnBoardingViewSeen, true);

                      Navigator.of(context).pushReplacementNamed(SignInView.routeName);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('تخط'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          title,
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyles.semiBold13.copyWith(color: const Color(0xff4e5456)),
            ),
          ),
        ],
      ),
    );
  }
}
