import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/orders/order_card.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';

class TrackOrderView extends StatelessWidget {
  const TrackOrderView({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "تتبع الطلبات"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            OrderCard(order: order, isVendor: false),
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
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RowBuilder(
                          icon: Icons.shopping_bag_outlined,
                          text: "تتبع الطلب",
                        ),
                        RowBuilder(
                          icon: Icons.check_box_outlined,
                          text: "تم قبول الطلب",
                        ),
                        RowBuilder(
                          icon: Icons.work_history_outlined,
                          text: "تم تجهيز الطلب",
                        ),
                        RowBuilder(
                          icon: Icons.local_shipping_outlined,
                          text: "قيد للتوصيل",
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

class RowBuilder extends StatelessWidget {
  RowBuilder({super.key, required this.icon, required this.text});
  IconData icon;
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(51, 69, 94, 114),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyles.bold16.copyWith(color: Colors.grey.shade800),
            ),
          ]),
          const SizedBox(
            height: 6,
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
          )
        ],
      ),
    );
  }
}
