import 'package:flutter/material.dart';

import 'package:just_mart/features/vendor_mode/widgets/add_product_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_orders_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_products_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/vendor_purchases_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/vendor_transition_choice_card.dart';

class VendorMenuview extends StatelessWidget {
  const VendorMenuview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "القائمة"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, MyOrders.routeName),
            child: const VendorTransitionChoice(
              choice: "الطلبات",
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, MyProducts.routeName),
            child: const VendorTransitionChoice(
              choice: "المنتجات",
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AddProduct.routeName),
            child: const VendorTransitionChoice(
              choice: "إضافة منتج",
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, VendorPurchases.routeName),
            child: const VendorTransitionChoice(
              choice: "المشتريات",
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const VendorTransitionChoice(
              choice: "العودة الى وضع الشراء",
            ),
          ),
        ],
      ),
    );
  }
}
