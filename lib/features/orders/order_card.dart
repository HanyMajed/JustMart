import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/services/firestore_service.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class OrderCard extends StatefulWidget {
  final OrderModel order;
  final bool isVendor;

  const OrderCard({
    super.key,
    required this.order,
    required this.isVendor,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String? _buyerName;
  bool _loadingName = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isVendor) {
      _loadBuyerName();
    }
  }

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
            // Your icon container remains the same
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
                    'طلب رقم: #${widget.order.orderId}',
                    style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'تم الطلب: ${widget.order.orderDate.year}-${widget.order.orderDate.month}-${widget.order.orderDate.day} الساعة: ${widget.order.orderDate.hour}:${widget.order.orderDate.minute}',
                      style: TextStyles.regular13.copyWith(color: const Color.fromARGB(255, 151, 151, 151))),
                  const SizedBox(height: 8),
                  Text(
                    'عدد المنتجات: #${widget.order.orderItems.length}       السعر: ${widget.order.totalPrice.toInt()} دينار',
                    style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  _buildNameText(),
                  const SizedBox(height: 8),
                  Text(
                    ' المنتجات: ${getItemsNames(widget.order.orderItems)}',
                    style: TextStyles.regular16.copyWith(color: Colors.grey.shade900),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameText() {
    if (widget.isVendor) {
      return Text(
        'الاسم: ${widget.order.vendorName}',
        style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
        overflow: TextOverflow.ellipsis,
      );
    }

    if (_loadingName) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return Text(
      'الاسم: ${_buyerName ?? 'جار التحميل...'}',
      style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
      overflow: TextOverflow.ellipsis,
    );
  }

  String getItemsNames(List<ProductItemModel> p) {
    return p.map((e) => e.productName).join(', ');
  }

  Future<void> _loadBuyerName() async {
    if (_loadingName) return;

    setState(() {
      _loadingName = true;
      _buyerName = null; // Clear previous value
    });

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.order.buyerId)
          .get()
          .timeout(const Duration(seconds: 10)); // Add timeout

      setState(() {
        _loadingName = false;
        if (userDoc.exists) {
          _buyerName = userDoc.data()?['name'] as String? ?? 'Unknown Buyer';
        } else {
          _buyerName = 'Buyer Not Found';
        }
      });
    } catch (e) {
      debugPrint('Error fetching user name: $e');
      setState(() {
        _loadingName = false;
        _buyerName = 'Error Loading Name';
      });
    }
  }
}
