import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.image, required this.text});

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color.fromARGB(255, 202, 202, 202),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyles.semiBold16,
            ),
          ),
        ],
      ),
    );
  }
}
