import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/cart/cart_provider.dart';
import 'package:just_mart/features/home/presentation/views/widgets/cart_item.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/widgets/custom_button.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  double? totalPrice;
  @override
  void initState() {
    totalPrice = context.read<CartProvider>().total;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: appbarForVendorViews(title: "السلة"),
      body: cartItems.isEmpty
          ? const Center(child: Text('لم يتم العثور على المنتجات'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        onRemove: () {
                          cartProvider.removeFromCart(cartItems[index].productId);
                          setState(() {
                            totalPrice = cartProvider.total;
                          });
                        },
                        product: cartItems[index],
                      );
                    },
                  ),
                ),
                SizedBox(
                    width: 280,
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
                        ),
                      ),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'تأكيد الطلب بقيمة  ',
                                style: TextStyles.semiBold16.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: cartProvider.total.toStringAsFixed(2),
                                style: TextStyles.semiBold16.copyWith(
                                  color: AppColors.seconderyColor,
                                ),
                              ),
                              TextSpan(
                                text: ' دينار',
                                style: TextStyles.semiBold16.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
    );
  }
}
