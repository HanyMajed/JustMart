import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/helper_functions/theam_provider.dart';
import 'package:just_mart/features/auth/signin_view.dart';
import 'package:just_mart/features/orders/order_model.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:provider/provider.dart'; // Required import
import 'package:just_mart/features/profile_page/presentation/widgets/primary_button.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/profile_header.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/profile_settings_list.dart';
import 'package:just_mart/widgets/confirmation_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = "profilescreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isStudentMode = false;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  Future<Map<String, dynamic>> _fetchUserData() async {
    if (_currentUserId == null) return {};

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUserId)
          .get();
      return doc.data() ?? {};
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'حسابي',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF202124),
            ),
          ),
          centerTitle: true,
          elevation: 1,
          shadowColor: Colors.grey.withOpacity(0.2),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _fetchUserData(),
          builder: (context, snapshot) {
            // Handle loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Get user data
            final userData = snapshot.data ?? {};
            final userName = userData['name'] ?? 'مستخدم جديد';

            return Column(
              children: [
                ProfileHeader(
                  email: FirebaseAuth.instance.currentUser?.email ??
                      'mail@mail.com',
                  name: userName, // Pass the fetched name
                  userStatus: 'حساب نشط',
                ),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),
                Expanded(
                  child: Consumer<ThemeProvider>(
                    // Now properly recognized
                    builder: (context, themeProvider, child) {
                      return ProfileSettingsList(
                        isDarkMode: themeProvider.isDarkMode,
                        isStudentMode: _isStudentMode,
                        onDarkModeChanged: (value) =>
                            themeProvider.toggleTheme(value),
                        onStudentModeChanged: (value) =>
                            setState(() => _isStudentMode = value),
                      );
                    },
                  ),
                ),
                PrimaryButton(
                  icon: Icons.logout,
                  text: 'تسجيل الخروج',
                  onPressed: () {
                    ConfirmationDialog.show(
                      context: context,
                      title: 'هل ترغب في تسجيل الخروج؟',
                      confirmText: 'نعم',
                      cancelText: 'إلغاء',
                      onConfirm: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // Navigator.of(context).pushReplacementNamed(SignInView.routeName);
                      },
                      onCancel: () {},
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<OrderModel?> getOrderById(String orderId) async {
    try {
      // Get the order document
      final orderDoc = await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .get();

      if (!orderDoc.exists) {
        log('Order not found: $orderId');
        return null;
      }

      final data = orderDoc.data() as Map<String, dynamic>;

      // Convert order items to ProductItemModel list
      List<ProductItemModel> items =
          (data['orderItems'] as List<dynamic>).map((item) {
        return ProductItemModel(
          productName: item['productName'] ?? '',
          productCategory: item['productCategory'] ?? '',
          vendorId: item['vendorId'] ?? '',
          price: item['price'] ?? '0',
          imageBase64: item['imageBase64'] ?? '',
          description: item['description'] ?? '',
        );
      }).toList();

      // Create OrderModel instance
      return OrderModel(
        orderId: data['orderId'] ?? orderDoc.id,
        buyerId: data['buyerId'] ?? '',
        vendorId: data['vendorId'] ?? '',
        totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0.0,
        orderStatus: data['orderStatus'] ?? 'Order Placed',
        orderDate:
            (data['orderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
        orderItems: items,
      )..vendorName = data['vendorName'] as String?;
    } catch (e, stackTrace) {
      log('Error fetching order', error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
