import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/orders/order_card.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/widgets/custom_button.dart';

class VendorTrackOrder extends StatefulWidget {
  const VendorTrackOrder({super.key, required this.order});
  final OrderModel order;

  @override
  State<VendorTrackOrder> createState() => _VendorTrackOrderState();
}

class _VendorTrackOrderState extends State<VendorTrackOrder> {
  String _selectedOption = 'تم قبول الطلب';

  @override
  Widget build(BuildContext context) {
    String orderStatus = "";
    return Scaffold(
      appBar: appbarForVendorViews(title: "تتبع الطلبات"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderCard(order: widget.order, isVendor: false),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('تم قبول الطلب', style: TextStyles.bold16),
                    leading: Radio<String>(
                      value: 'تم قبول الطلب',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('تم تجهيز الطلب', style: TextStyles.bold16),
                    leading: Radio<String>(
                      value: 'تم تجهيز الطلب',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('قيد للتوصيل', style: TextStyles.bold16),
                    leading: Radio<String>(
                      value: 'قيد للتوصيل',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('تم التسليم', style: TextStyles.bold16),
                    leading: Radio<String>(
                      value: 'تم التسليم',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: CustomButton(
                  onPressed: () {
                    if (_selectedOption == 'تم قبول الطلب') {
                      orderStatus = "OrderPlaced";
                    }
                    if (_selectedOption == 'تم تجهيز الطلب') {
                      orderStatus = "OrderPrepared";
                    }
                    if (_selectedOption == 'قيد للتوصيل') {
                      orderStatus = "OrderOnDelivery";
                    }

                    if (_selectedOption == 'تم التسليم') {
                      orderStatus = "OrderDelivered";
                    }
                    FirebaseFirestore.instance.collection('orders').doc(widget.order.orderId).update({'orderStatus': orderStatus});
                    Navigator.pop(context);
                  },
                  text: 'تأكيد حالة الطلب'),
            )
          ],
        ),
      ),
    );
  }
}
