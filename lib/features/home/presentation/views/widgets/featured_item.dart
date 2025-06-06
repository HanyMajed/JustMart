import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/featured_button.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.discount,
  });
  final String imagePath;
  final String title;
  final String discount;
  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.sizeOf(context).width - 32;
    return SingleChildScrollView(
      child: ClipRRect(
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
                    imagePath,
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
                      child: // Inside FeaturedItem's Column:
                          Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(flex: 2), // Replaces SizedBox(height:25)
                          Text(
                            title,
                            style: TextStyles.regular13
                                .copyWith(color: Colors.white),
                            textAlign:
                                TextAlign.center, // Ensure text stays centered
                          ),
                          const Spacer(), // Replaces SizedBox(height:11)
                          Text(
                            discount,
                            style:
                                TextStyles.bold19.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(), // Replaces SizedBox(height:11)
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 32),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16), // Reduced size
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 16),
                            ],
                          ),
                          const Spacer(flex: 2), // Replaces SizedBox(height:29)
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
