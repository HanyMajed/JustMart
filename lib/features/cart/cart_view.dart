import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: Column(
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
            width: 200,
            child: CustomButton(
              onPressed: () {},
              text: "تأكيد الطلب بقيمة ${cartProvider.total.toStringAsFixed(2)},",
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
