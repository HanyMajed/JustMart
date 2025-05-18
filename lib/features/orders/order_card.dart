import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/orders/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade400,
                        radius: 24,
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 28,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),

                      /// Main content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'طلب رقم: #${order.orderId}',
                              style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 4),

                            /// Order date
                            Text(
                              'تم الطلب: ${order.orderDate}',
                              style: TextStyles.regular13.copyWith(color: const Color.fromARGB(255, 151, 151, 151)),
                            ),

                            const SizedBox(height: 8),

                            /// Count and price
                            Row(
                              children: [
                                Text(
                                  'عدد المنتجات:',
                                  style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${order.orderItems.length}',
                                  style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                                ),
                                const Spacer(),
                                Flexible(
                                  child: Text(
                                    '${order.totalPrice.toInt()} دينار',
                                    style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
