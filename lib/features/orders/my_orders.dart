import 'package:flutter/material.dart';
import 'package:just_mart/features/orders/order_card.dart';
import 'package:just_mart/features/orders/order_model.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return OrderCard(
      order: order,
    );
  }
}
