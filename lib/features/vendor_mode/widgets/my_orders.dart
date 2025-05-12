import 'package:flutter/material.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});
  static const String routeName = "MyOrders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "الطلبات"),
    );
  }
}
