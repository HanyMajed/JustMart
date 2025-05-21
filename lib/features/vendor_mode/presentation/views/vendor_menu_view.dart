import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/vendor_mode/widgets/add_product_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/orders_to_be_delivered.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_products_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/features/vendor_mode/widgets/vendor_purchases_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/vendor_transition_choice_card.dart';

class VendorMenuview extends StatelessWidget {
  const VendorMenuview({super.key, required this.signedUID});
  final String signedUID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "القائمة"),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdersToBeDelivered(
                    signedUID: signedUID,
                  ),
                )),
            child: VendorTransitionChoice(
              signedUID: signedUID,
              choice: "الطلبات",
              icon: Icons.receipt_long,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyProducts(
                          signedUID: signedUID,
                        ))),
            child: VendorTransitionChoice(
              icon: Icons.style_sharp,
              signedUID: signedUID,
              choice: "المنتجات",
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddProductView(
                          signedUID: signedUID,
                        ))),
            child: VendorTransitionChoice(
              signedUID: signedUID,
              choice: "إضافة منتج",
              icon: Icons.add_box_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
