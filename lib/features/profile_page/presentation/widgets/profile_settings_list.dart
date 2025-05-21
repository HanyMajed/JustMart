import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/orders/buyer_all_orders.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/favourite_screen.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/my_payment_cards.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/my_profile_info_page.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/who_are_we_page.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'profile_list_item.dart';

class ProfileSettingsList extends StatefulWidget {
  final bool isDarkMode;
  final bool isStudentMode;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<bool> onStudentModeChanged;

  const ProfileSettingsList({
    super.key,
    required this.isDarkMode,
    required this.isStudentMode,
    required this.onDarkModeChanged,
    required this.onStudentModeChanged,
  });

  @override
  State<ProfileSettingsList> createState() => _ProfileSettingsListState();
}

class _ProfileSettingsListState extends State<ProfileSettingsList> {
  @override
  Widget build(BuildContext context) {
    const iconColor = Color(0xFF5F6368);

    final menuItems = [
      ProfileListItem(
        icon: Icons.person_outline,
        title: 'الملف الشخصي',
        onTap: () {
          Navigator.pushNamed(context, MyProfileInfoPage.routeName);
        },
        color: AppColors.lightprimaryColor,
      ),
      ProfileListItem(
        icon: Icons.add_box,
        title: 'طلباتي',
        onTap: () async {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser == null) return;

          final orderIds = await _getUserOrderIds(currentUser.uid);
          if (orderIds.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("لا يوجد طلبات حالياً")),
            );
            return;
          }

          // Get the first order (or modify to handle multiple orders)
          final firstOrderId = orderIds.first;
          final order = await _getOrderById(firstOrderId, currentUser.uid);

          if (order != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BuyerAllOrders(order: order),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("حدث خطأ في تحميل الطلب")),
            );
          }
        },
        color: AppColors.lightprimaryColor,
      ),
      ProfileListItem(
        icon: Icons.wallet,
        title: 'المدفوعات',
        onTap: () {
          Navigator.pushNamed(context, MyPaymentCards.routeName);
        },
        color: AppColors.lightprimaryColor,
      ),
      ProfileListItem(
        icon: Icons.favorite_outline_outlined,
        title: 'المفضله',
        onTap: () {
          Navigator.pushNamed(context, FavouriteScreen.routeName);
        },
        color: AppColors.lightprimaryColor,
      ),

      ProfileListItem(
        icon: Icons.notifications_none_outlined,
        title: 'الاشعارات',
        color: AppColors.lightprimaryColor,
        trailing: Switch(
          value: widget.isStudentMode,
          activeColor: AppColors.lightprimaryColor,
          onChanged: widget.onStudentModeChanged,
        ),
      ),
      ProfileListItem(
        icon: Icons.sports_basketball_outlined,
        title: 'اللغه',
        onTap: () {},
        color: AppColors.lightprimaryColor,
      ),
      ProfileListItem(
        icon: Icons.mode_edit_outlined,
        title: 'الوضع',
        color: AppColors.lightprimaryColor,
        trailing: Switch(
          value: widget.isDarkMode, // Now using dark mode state
          activeColor: AppColors.lightprimaryColor,
          onChanged: widget.onDarkModeChanged, // Now using dark mode callback
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: Text(
          'المساعده',
          style: TextStyles.bold13,
        ),
      ),
      ProfileListItem(
        icon: Icons.error_outline_outlined,
        title: 'من نحن',
        onTap: () {
          Navigator.pushNamed(context, WhoAreWePage.routeName);
        },
        color: AppColors.lightprimaryColor,
      ),
      // ... Add other menu items following the same pattern
    ];

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8),
      itemCount: menuItems.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 24),
      itemBuilder: (context, index) => menuItems[index],
    );
  }

  Future<List<String>> _getUserOrderIds(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      return (userDoc.data()?['allOrders'] as List<dynamic>?)?.cast<String>() ?? [];
    } catch (e) {
      debugPrint('Error fetching order IDs: $e');
      return [];
    }
  }

  Future<OrderModel?> _getOrderById(String orderId, String userId) async {
    try {
      final orderDoc = await FirebaseFirestore.instance.collection('orders').doc(orderId).get();

      if (!orderDoc.exists) return null;

      final data = orderDoc.data() as Map<String, dynamic>;

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

      return OrderModel(
        orderId: data['orderId'] ?? orderId,
        buyerId: data['buyerId'] ?? userId,
        vendorId: data['vendorId'] ?? '',
        totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0.0,
        orderStatus: data['orderStatus'] ?? 'Order Placed',
        orderDate: (data['orderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
        orderItems: items,
      )..vendorName = data['vendorName'] as String?;
    } catch (e) {
      debugPrint('Error fetching order: $e');
      return null;
    }
  }
}
