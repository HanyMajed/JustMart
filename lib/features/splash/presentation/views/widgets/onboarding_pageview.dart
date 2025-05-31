import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/splash/presentation/views/widgets/pageitem_view.dart';

class OnboardingPageview extends StatelessWidget {
  const OnboardingPageview({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        controller: pageController,
        children: [
          PageVIewItem(
            isVisible: (pageController.hasClients ? pageController.page!.round() : 0) == 0,
            image: Assets.assetsImagesOnboarding1,
            backgroungImage: Assets.assetsImagesItemViewpage1BackgroundImage,
            subTitle:
                "اكتشف تجربة تسوق مميزة مع JUST MART - المنصة الأولى المخصصة لمجتمع جامعة العلوم والتكنولوجيا. استعرض مشاريع الطلاب الإبداعية، المنتجات اليدوية الفريدة، والعروض الحصرية بأسعار تنافسية، كل ذلك ضمن بيئة آمنة ومخصصة لأعضاء الجامعة فقط.",
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'مرحبًا بك في ',
                  style: TextStyles.bold23,
                ),
                Text(
                  'MART',
                  style: TextStyles.bold23.copyWith(color: AppColors.seconderyColor),
                ),
                Text(
                  'JUST',
                  style: TextStyles.bold23.copyWith(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          PageVIewItem(
            isVisible: (pageController.hasClients ? pageController.page!.round() : 0) == 0,
            image: Assets.assetsImagesOnboarding2,
            backgroungImage: Assets.assetsImagesItemViewpage2BackgroundImage,
            subTitle:
                "نُقدِّم لك أفضل المنتجات الطلابية المميزة المُصمَّمة بأيدي طلاب جامعة العلوم والتكنولوجيا. اطَّلِع على التفاصيل الفريدة، الصور التوضيحية، وتقييمات المُستخدمين لتتأكَّد من دعمك للمشاريع الريادية التي تُلبي احتياجاتك وتُعزِّز روح الإبداع داخل الحرم الجامعي.",
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ابحث وتسوق',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
