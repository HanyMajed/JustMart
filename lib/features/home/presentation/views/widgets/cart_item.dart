import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/quantity_selector.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.5, color: Color.fromARGB(144, 180, 180, 180)),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/electronics_test.png',
            height: 80,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "اسم المنتج",
              style: TextStyles.semiBold16,
            ),
            QuantitySelector(onChanged: (value) {})
          ]),
          const Spacer(),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Icon(
              Icons.delete,
              color: Colors.grey,
              size: 24,
            ),
            Row(
              children: [
                Text(
                  "jod ",
                  style: TextStyles.bold16.copyWith(color: AppColors.seconderyColor),
                ),
                Text(
                  "3 ",
                  style: TextStyles.bold16.copyWith(color: AppColors.seconderyColor),
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }
}
