import 'package:flutter/material.dart';
import 'package:just_mart/features/vendor_mode/widgets/add_product_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/delete_product_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/orders_to_be_delivered.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_products_view.dart';
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
              choice: "طلبات الزبائن",
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
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DeleteProductView(
                          signedUID: signedUID,
                        ))),
            child: VendorTransitionChoice(
              signedUID: signedUID,
              choice: "حذف منتج",
              icon: Icons.delete_outline_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
