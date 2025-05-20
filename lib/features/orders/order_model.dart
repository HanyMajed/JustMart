import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class OrderModel {
  final String orderId;
  final String vendorId;
  final String buyerId;
  final double totalPrice;
  final String orderStatus;
  final DateTime orderDate;
  final List<ProductItemModel> orderItems;

  String? vendorName; // Made nullable since it's loaded asynchronously
  final FirebaseFirestore _firestore;

  OrderModel({
    required this.vendorId,
    required this.buyerId,
    required this.totalPrice,
    required this.orderItems,
    String? orderId,
    DateTime? orderDate,
    this.orderStatus = "Order Placed",
    FirebaseFirestore? firestore,
  })  : orderId = orderId ?? FirebaseFirestore.instance.collection('orders').doc().id,
        orderDate = orderDate ?? DateTime.now(),
        _firestore = firestore ?? FirebaseFirestore.instance;

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

  Future<void> loadVendorName() async {
    try {
      final vendorSnapshot = await _firestore.collection(BackendEndpoints.getUserData).doc(vendorId).get();

      if (vendorSnapshot.exists) {
        vendorName = vendorSnapshot.data()?['name'] as String? ?? '';
      } else {
        log('Vendor not found for ID: $vendorId');
      }
    } catch (e, stackTrace) {
      log('Error fetching vendor name', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> placeOrder(String uid) async {
    try {
      // Ensure vendor name is loaded first
      await loadVendorName();

      await _firestore.collection('orders').doc(orderId).set({
        'vendorName': vendorName,
        'orderId': orderId,
        'buyerId': buyerId,
        'vendorId': vendorId, // Use class-level vendorId
        'totalPrice': totalPrice,
        'orderStatus': orderStatus,
        'orderDate': Timestamp.fromDate(orderDate),
        'orderItems': orderItemsToFirestore(),
      });

      await _firestore.collection('users').doc(uid).update({
        'allOrders': FieldValue.arrayUnion([orderId])
      });
    } catch (e, stackTrace) {
      log('Order failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
