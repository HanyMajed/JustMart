import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class OrderModel {
  final String orderId; // Changed to String to match Firestore IDs
  final String buyerId;
  final double totalPrice;
  final String orderStatus;
  final DateTime orderDate;
  final List<ProductItemModel> orderItems;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  OrderModel({
    required this.buyerId,
    required this.totalPrice,
    required this.orderItems,
    String? orderId,
    DateTime? orderDate,
    this.orderStatus = "Order Placed",
  })  : orderId = orderId ?? FirebaseFirestore.instance.collection('orders').doc().id,
        orderDate = orderDate ?? DateTime.now();

  List<Map<String, dynamic>> orderItemsToFirestore() {
    return orderItems.map((item) {
      assert(item.productId.isNotEmpty, 'Product ID cannot be empty');
      assert(item.vendorId.isNotEmpty, 'Vendor ID cannot be empty');

      return {
        'productId': item.productId,
        'productName': item.productName,
        'productCategory': item.productCategory,
        'vendorId': item.vendorId,
        'price': item.price,
        'quantity': item.quantity,
        'imageBase64': item.imageBase64,
        'description': item.description,
      };
    }).toList();
  }

  Future<void> placeOrder(String uid) async {
    try {
      // Use the already generated orderId as the document ID
      await firestore.collection('orders').doc(orderId).set({
        'orderId': orderId,
        'buyerId': buyerId,
        'totalPrice': totalPrice,
        'orderStatus': orderStatus,
        'orderDate': Timestamp.fromDate(orderDate),
        'orderItems': orderItemsToFirestore(),
      });

      await firestore.collection('users').doc(uid).update({
        'allOrders': FieldValue.arrayUnion([orderId])
      });
    } catch (e) {
      log('Order failed', error: e, stackTrace: StackTrace.current);
      rethrow;
    }
  }
}
