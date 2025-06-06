import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/category/category_item.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key, required this.signedUID});
  final String signedUID;
  final List<Map<String, String>> categories = [
    {"text": "الكل", "image": "assets/images/all.png"},
    {"text": "لوازم الدراسة", "image": "assets/images/studying.jpg"},
    {"text": "التقنية والإلكترونيات", "image": "assets/images/electronics_test.png"},
    {"text": "الملابس والموضة", "image": "assets/images/clothes.jpg"},
    {"text": "الطعام والحلويات", "image": "assets/images/food.jpg"},
    {"text": "الترفيه والهوايات", "image": "assets/images/hobbies.jpg"},
    {"text": "الإكسوارات", "image": "assets/images/accessories.jpg"},
    {"text": "غيرها", "image": "assets/images/other.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'الاقسام',
                          style: TextStyles.bold19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: categories
                      .map((category) => GestureDetector(
                            onTap: () {
                              // Return the selected category when tapped
                              Navigator.pop(context, category['text']!);
                            },
                            child: CategoryItem(
                              image: category['image']!,
                              text: category['text']!,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
