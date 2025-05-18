import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/cart/cart_provider.dart';
import 'package:just_mart/features/home/presentation/views/widgets/quantity_selector.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class CartItem extends StatefulWidget {
  final ProductItemModel product;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.product,
    required this.onRemove,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.5, color: Color.fromARGB(144, 180, 180, 180)),
        ),
      ),
      child: Row(
        children: [
          // Display actual product image (convert from base64)
          Image.memory(
            base64Decode(widget.product.imageBase64),
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.productName,
                style: TextStyles.semiBold16,
              ),
              QuantitySelector(
                initialValue: widget.product.quantity,
                onChanged: (newQuantity) {
                  cartProvider.updateQuantity(widget.product.productId, newQuantity);
                },
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey, size: 24),
                onPressed: widget.onRemove,
              ),
              Row(
                children: [
                  Text(
                    "JOD ",
                    style: TextStyles.bold16.copyWith(color: AppColors.seconderyColor),
                  ),
                  Text(
                    widget.product.price,
                    style: TextStyles.bold16.copyWith(color: AppColors.seconderyColor),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
