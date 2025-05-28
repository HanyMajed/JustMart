import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/orders/order_card.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/orders/status_row_builder.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class BuyerTrackOrderView extends StatefulWidget {
  const BuyerTrackOrderView({super.key, required this.order});
  final OrderModel order;

  @override
  State<BuyerTrackOrderView> createState() => _BuyerTrackOrderViewState();
}

class _BuyerTrackOrderViewState extends State<BuyerTrackOrderView> {
  OrderModel? updatedOrder;
  bool isLoading = true;
  @override
  void initState() {
    log(widget.order.orderStatus);
    _getOrderById(widget.order.orderId, widget.order.buyerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(
        title: "تتبع الطلب",
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                              const SizedBox(height: 12),
                              Center(
                                child: Text(
                                  "تتبع الطلب",
                                  style: TextStyles.bold19.copyWith(color: Colors.grey.shade800),
                                ),
                              ),
                              RowBuilder(
                                isColored: updatedOrder!.orderStatus == "OrderPlaced" ? true : false,
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
                                isColored: updatedOrder!.orderStatus == "OrderPrepared" ? true : false,
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
                                isColored: updatedOrder!.orderStatus == "OrderOnDelivery" ? true : false,
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
                                isColored: updatedOrder!.orderStatus == "OrderDelivered" ? true : false,
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

  Future<OrderModel?> _getOrderById(String orderId, String userId) async {
    try {
      final orderDoc = await FirebaseFirestore.instance.collection('orders').doc(orderId).get();

      if (!orderDoc.exists) return null;

      final data = orderDoc.data() as Map<String, dynamic>;

      List<ProductItemModel> items = (data['orderItems'] as List<dynamic>).map((item) {
        return ProductItemModel(
          productName: item['productName'] ?? '',
          productCategory: item['productCategory'] ?? '',
          vendorId: item['vendorId'] ?? '',
          price: item['price'] ?? '0',
          imageBase64: item['imageBase64'] ?? '',
          description: item['description'] ?? '',
        );
      }).toList();

      updatedOrder = OrderModel(
        orderId: data['orderId'] ?? orderId,
        buyerId: data['buyerId'] ?? userId,
        vendorId: data['vendorId'] ?? '',
        totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0.0,
        orderStatus: data['orderStatus'] ?? 'Order Placed',
        orderDate: (data['orderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
        orderItems: items,
      )..vendorName = data['vendorName'] as String?;
      isLoading = false;
      setState(() {});
    } catch (e) {
      debugPrint('Error fetching order: $e');
      return null;
    }
    return null;
  }
}
