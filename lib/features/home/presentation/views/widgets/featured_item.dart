import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/featured_button.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.sizeOf(context).width - 32;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: itemWidth,
        child: AspectRatio(
          aspectRatio: 342 / 158,
          child: Stack(
            children: [
              Positioned(
                left: -3,
                bottom: 0,
                top: 0,
                right: itemWidth * .4,
                child: Image.asset(
                  Assets.assetsImagesElectronicsTest,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: itemWidth * .5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: svg.Svg(Assets.assetsImagesFeaturedItem),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'عروض العيد',
                        style: TextStyles.regular13.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'خصم 25%',
                        style: TextStyles.bold19.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      FeaturedItemButton(
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 29,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
