import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/features/orders/order_card.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/features/orders/order_model.dart'; // Make sure to import OrderModel

class OrdersToBeDelivered extends StatelessWidget {
  const OrdersToBeDelivered({super.key, required this.signedUID});
  static const String routeName = "MyOrders";
  final String signedUID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "طلبات الزبائن"),
      body: FutureBuilder<List<OrderModel>>(
        future: getUserOrdersToDeliver(signedUID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return const Center(child: Text('لا توجد طلبات لتسليمها حالياً'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderCard(
                order: order,
              ); // You'll need to create this widget
            },
          );
        },
      ),
    );
  }

  Future<List<OrderModel>> getUserOrdersToDeliver(String userId) async {
    try {
      // 1. Get the user document
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      // 2. Get the list of order IDs from ordersToDeliver
      final orderIds = (userDoc.data()?['orderToDeliver'] as List<dynamic>?)?.cast<String>() ?? [];

      if (orderIds.isEmpty) {
        return []; // No orders to deliver
      }

      // 3. Fetch all order documents at once
      final ordersSnapshot = await FirebaseFirestore.instance.collection('orders').where(FieldPath.documentId, whereIn: orderIds).get();

      // 4. Convert to OrderModel objects
      final orders = <OrderModel>[];
      for (final doc in ordersSnapshot.docs) {
        final data = doc.data();

        orders.add(OrderModel(
          orderId: doc.id,
          vendorId: data['vendorId'] ?? '',
          buyerId: data['buyerId'] ?? userId,
          totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0.0,
          orderStatus: data['orderStatus'] ?? 'Order Placed',
          orderItems: (data['orderItems'] as List<dynamic>).map((item) {
            return ProductItemModel(
              productName: item['productName'] ?? '',
              productCategory: item['productCategory'] ?? '',
              vendorId: item['vendorId'] ?? '',
              price: item['price'] ?? '0',
              imageBase64: item['imageBase64'] ?? '',
              description: item['description'] ?? '',
            );
          }).toList(),
          orderDate: (data['orderDate'] as Timestamp?)?.toDate(),
        )..vendorName = data['vendorName'] as String?);
      }

      return orders;
    } catch (e) {
      throw 'فشل تحميل الطلبات: ${e.toString()}';
    }
  }
}
