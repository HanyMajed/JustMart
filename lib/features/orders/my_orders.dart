import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/cart/cart_provider.dart';
import 'package:just_mart/features/orders/order_card.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key, required this.order});
  final OrderModel order;

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<OrderModel> userOrders = [];
  bool isLoading = true;
  String? error;
  @override
  void initState() {
    super.initState();
    getVendorOrders();

    // Safely clear the cart after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().clearCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "الطلبات"),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text('حدث خطأ: $error'))
              : userOrders.isEmpty
                  ? const Center(child: Text("لا يوجد طلبات حالياً"))
                  : ListView.builder(
                      itemCount: userOrders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          order: userOrders[index],
                        );
                      },
                    ),
    );
  }

  Future<void> getVendorOrders() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('vendorId', isEqualTo: widget.order.vendorId)
          .where('buyerId', isEqualTo: widget.order.buyerId)
          .get();

      List<OrderModel> tempOrders = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

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

        OrderModel order = OrderModel(
          orderId: data['orderId'] ?? doc.id,
          buyerId: data['buyerId'] ?? '',
          vendorId: data['vendorId'] ?? '',
          totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0.0,
          orderStatus: data['orderStatus'] ?? 'Order Placed',
          orderDate: (data['orderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
          orderItems: items,
        );

        order.vendorName = data['vendorName'] ?? '';
        tempOrders.add(order);
      }

      setState(() {
        userOrders = tempOrders;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }
}
