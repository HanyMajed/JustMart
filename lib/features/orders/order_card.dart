import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/services/firestore_service.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
      child: Container(
        height: 175,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 247, 247),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 204, 204, 204),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.primaryColor,
                size: 60,
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'طلب رقم: #${order.orderId}',
                  style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'تم الطلب: ${order.orderDate.year}-${order.orderDate.month}-${order.orderDate.day} الساعة: ${order.orderDate.hour}:${order.orderDate.minute}',
                  style: TextStyles.regular13.copyWith(color: const Color.fromARGB(255, 151, 151, 151)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'عدد المنتجات: #${order.orderItems.length}       السعر: ${order.totalPrice.toInt()} دينار',
                  style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'الاسم: : ${order.vendorName}',
                  style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  ' المنتجات: ${getItemsNames(order.orderItems)}',
                  style: TextStyles.regular16.copyWith(color: Colors.grey.shade900),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  String getItemsNames(List<ProductItemModel> p) {
    List<String> names = [];
    for (var element in p) {
      names.add(element.productName);
    }
    return names.join(', ');
  }
}
