import 'package:flutter/material.dart';
import 'package:just_mart/features/home/presentation/views/widgets/cart_item.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "السلة"),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return CartItem();
          }),
    );
  }
}
