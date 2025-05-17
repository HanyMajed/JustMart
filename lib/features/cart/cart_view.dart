import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/features/cart/cart_provider.dart';
import 'package:just_mart/features/home/presentation/views/widgets/cart_item.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: appbarForVendorViews(title: "السلة"),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return CartItem(
            onRemove: () {
              cartProvider.removeFromCart(cartItems[index].productId);
            },
            product: cartItems[index],
          );
        },
      ),
    );
  }
}
