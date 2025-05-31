import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/features/home/presentation/views/widgets/featured_item.dart';

class FeaturedList extends StatelessWidget {
  final List<Map<String, String>> banners = [
    {
      'image': Assets.assetsImagesAll,
      'title': 'إسحب الشاشة',
      'discount': 'تصفح الاقسام',
    },
    {
      'image': Assets.assetsImagesStudying,
      'title': 'كل ما تحتاجه',
      'discount': 'لوازم الدراسة',
    },
    {
      'image': Assets.assetsImagesClothes,
      'title': 'أحدث الصيحات',
      'discount': 'الملابس والموضة',
    },
    {
      'image': Assets.assetsImagesFood,
      'title': 'ذوق لا يُقاوم',
      'discount': 'الطعام والحلويات',
    },
    {
      'image': Assets.assetsImagesHobbies,
      'title': 'استمتع بوقتك',
      'discount': 'الترفيه والهوايات',
    },
    {
      'image': Assets.assetsImagesAccessories,
      'title': 'أضف لمستك',
      'discount': 'الاكسسوارات',
    },
    {
      'image': Assets.assetsImagesOther,
      'title': 'تسوق أكثر',
      'discount': 'غيرها',
    },
  ];

  FeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: banners.map((banner) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FeaturedItem(
              imagePath: banner['image']!,
              title: banner['title']!,
              discount: banner['discount']!,
            ),
          );
        }).toList(),
      ),
    );
  }
}
