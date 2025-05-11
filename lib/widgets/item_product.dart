import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F5F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            //top: 0,
            //right: 0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  Assets.assetsImagesShoes,
                ),
                const SizedBox(
                  height: 24,
                ),
                ListTile(
                  title: const Text(
                    'احذية',
                    style: TextStyles.semiBold16,
                  ),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '20 دينار',
                          style: TextStyles.bold13.copyWith(
                            color: AppColors.seconderyColor,
                          ),
                        ),
                        TextSpan(
                          text: '/',
                          style: TextStyles.bold13.copyWith(
                            color: AppColors.lightseconderyColor,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyles.semiBold13.copyWith(
                            color: AppColors.seconderyColor,
                          ),
                        ),
                        TextSpan(
                          text: 'pair',
                          style: TextStyles.semiBold13.copyWith(
                            color: AppColors.lightseconderyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
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
