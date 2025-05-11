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
    return PageView(
      controller: pageController,
      children: [
        PageVIewItem(
          isVisible: (pageController.hasClients ? pageController.page!.round() : 0) == 0,
          image: Assets.assetsImagesItemViewpage1Image,
          backgroungImage: Assets.assetsImagesItemViewpage1BackgroundImage,
          subTitle:
              'اكتشف تجربة تسوق فريدة مع FruitHUB. استكشف مجموعتنا الواسعة من الفواكه الطازجة الممتازة واحصل على أفضل العروض والجودة العالية.',
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'مرحبًا بك في ',
                style: TextStyles.bold23,
              ),
              Text(
                'HUB',
                style: TextStyles.bold23.copyWith(color: AppColors.seconderyColor),
              ),
              Text(
                'Fruit',
                style: TextStyles.bold23.copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
        PageVIewItem(
          isVisible: (pageController.hasClients ? pageController.page!.round() : 0) == 0,
          image: Assets.assetsImagesItemViewpage2Image,
          backgroungImage: Assets.assetsImagesItemViewpage2BackgroundImage,
          subTitle: 'نقدم لك أفضل الفواكه المختارة بعناية. اطلع على التفاصيل والصور والتقييمات لتتأكد من اختيار الفاكهة المثالية',
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
    );
  }
}
