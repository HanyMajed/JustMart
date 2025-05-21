import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/orders/order_card.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/orders/status_row_builder.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';

class BuyerTrackOrderView extends StatefulWidget {
  const BuyerTrackOrderView({super.key, required this.order});
  final OrderModel order;

  @override
  State<BuyerTrackOrderView> createState() => _BuyerTrackOrderViewState();
}

class _BuyerTrackOrderViewState extends State<BuyerTrackOrderView> {
  @override
  void initState() {
    log(widget.order.orderStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "تتبع الطلبات"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            OrderCard(order: widget.order, isVendor: false),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    //padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        Center(
                          child: Text(
                            "تتبع الطلب",
                            style: TextStyles.bold19.copyWith(color: Colors.grey.shade800),
                          ),
                        ),
                        RowBuilder(
                          isColored: widget.order.orderStatus == "OrderPlaced" ? true : false,
                          icon: Icons.check_box_outlined,
                          text: "تم قبول الطلب",
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                          indent: 60,
                          endIndent: 60,
                        ),
                        RowBuilder(
                          isColored: widget.order.orderStatus == "OrderPrepared" ? true : false,
                          icon: Icons.work_history_outlined,
                          text: "تم تجهيز الطلب",
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                          indent: 60,
                          endIndent: 60,
                        ),
                        RowBuilder(
                          isColored: widget.order.orderStatus == "OrderOnDelivery" ? true : false,
                          icon: Icons.local_shipping_outlined,
                          text: "قيد للتوصيل",
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                          indent: 60,
                          endIndent: 60,
                        ),
                        RowBuilder(
                          isColored: widget.order.orderStatus == "OrderDelivered" ? true : false,
                          icon: Icons.local_shipping_outlined,
                          text: "تم التسليم",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
