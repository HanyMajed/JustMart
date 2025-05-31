import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/orders/order_model.dart';
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
  String location = 'جار التحميل...'; // Initialize with loading text
  bool _loadingLocation = false;
  String? phoneNumber;
  @override
  void initState() {
    super.initState();
    // Use model's location first
    location = widget.order.deliveryLocation;
    // Then try to update from Firestore
    _retrieveDeliveryLocation();
    if (!widget.isVendor) {
      _loadBuyerName();
    }
    _loadPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
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
                    'طلب رقم: #${widget.order.orderId}',
                    style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'تم الطلب: ${widget.order.orderDate.year}-${widget.order.orderDate.month}-${widget.order.orderDate.day} الساعة: ${widget.order.orderDate.hour}:${widget.order.orderDate.minute}',
                    style: TextStyles.regular13.copyWith(color: const Color.fromARGB(255, 151, 151, 151)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'عدد المنتجات: #${widget.order.orderItems.length}       السعر: ${widget.order.totalPrice.toInt()} دينار',
                    style: TextStyles.bold16.copyWith(color: Colors.grey.shade900),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  _buildNameText(),
                  const SizedBox(height: 4),
                  _buildLocationText(),
                  Text(
                    'المنتجات: ${getItemsNames(widget.order.orderItems)}',
                    style: TextStyles.regular16.copyWith(color: Colors.grey.shade900),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    'رقم البائع: ${phoneNumber}',
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

  Future<void> _loadPhoneNumber() async {
    final fetchedPhone = await getUserPhoneNumber(widget.order.vendorId);
    if (mounted) {
      setState(() {
        phoneNumber = fetchedPhone;
      });
    }
  }

  Future<String?> getUserPhoneNumber(String vendorId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      DocumentSnapshot vendorDoc = await firestore.collection('users').doc(vendorId).get();

      if (!vendorDoc.exists) {
        print("Vendor not found");
        return null;
      }

      String phoneNumber = vendorDoc.get('phoneNumber');
      return phoneNumber;
    } catch (e) {
      print("Error: $e");
      return "لا يوجد رقم";
    }
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

  Widget _buildLocationText() {
    if (_loadingLocation) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return Text(
      'موقع التوصيل: $location',
      style: TextStyles.bold13.copyWith(color: Colors.grey.shade900),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  String getItemsNames(List<ProductItemModel> p) {
    return p.map((e) => e.productName).join(', ');
  }

  Future<void> _retrieveDeliveryLocation() async {
    if (_loadingLocation) return;

    setState(() => _loadingLocation = true);

    try {
      final doc = await FirebaseFirestore.instance.collection('orders').doc(widget.order.orderId).get().timeout(const Duration(seconds: 5));

      if (doc.exists) {
        final updatedLocation = doc.data()?['deliveryLocation'] as String?;
        if (updatedLocation != null && updatedLocation != location && mounted) {
          setState(() {
            location = updatedLocation;
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching location: $e');
      // Keep the existing location value
    } finally {
      if (mounted) {
        setState(() => _loadingLocation = false);
      }
    }
  }

  Future<void> _loadBuyerName() async {
    if (_loadingName) return;

    setState(() {
      _loadingName = true;
      _buyerName = null;
    });

    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(widget.order.buyerId).get().timeout(const Duration(seconds: 10));

      if (mounted) {
        setState(() {
          _loadingName = false;
          if (userDoc.exists) {
            _buyerName = userDoc.data()?['name'] as String? ?? 'مشتري غير معروف';
          } else {
            _buyerName = 'لم يتم العثور على المشتري';
          }
        });
      }
    } catch (e) {
      debugPrint('Error fetching user name: $e');
      if (mounted) {
        setState(() {
          _loadingName = false;
          _buyerName = 'خطأ في تحميل الاسم';
        });
      }
    }
  }
}
