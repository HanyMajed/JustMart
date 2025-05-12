import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/features/home/presentation/views/home_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/add_product.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_orders.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_products.dart';
import 'package:just_mart/features/vendor_mode/widgets/vendor_transition_choices.dart';

class VendorTransitionview extends StatelessWidget {
  const VendorTransitionview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, MyOrders.routeName),
            child: const VendorTransitionChoices(
              choice: "الطلبات",
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, MyProducts.routeName),
            child: const VendorTransitionChoices(
              choice: "المنتجات",
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AddProduct.routeName),
            child: const VendorTransitionChoices(
              choice: "إضافة منتج",
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const VendorTransitionChoices(
              choice: "العودة الى وضع الشراء",
            ),
          ),
        ],
      ),
    );
  }
}
