import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/features/home/presentation/views/widgets/featured_item.dart';

class FeaturedList extends StatelessWidget {
  final List<Map<String, String>> banners = [
    {
      'image': Assets.assetsImagesElectronicsTest,
      'title': 'العروض المميزة',
      'discount': 'خصم 30%',
    },
    {
      'image': Assets.assetsImagesClothes,
      'title': 'تنزيلات الصيف',
      'discount': 'خصم 50%',
    },
    {
      'image': Assets.assetsImagesShoes,
      'title': 'عروض المنزل',
      'discount': 'خصم 25%',
    },
    {
      'image': Assets.assetsImagesStudying,
      'title': 'عروض رياضية',
      'discount': 'خصم 40%',
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
