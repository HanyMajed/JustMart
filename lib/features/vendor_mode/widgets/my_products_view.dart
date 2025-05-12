import 'package:flutter/material.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';

class MyProducts extends StatelessWidget {
  const MyProducts({super.key});
  static const String routeName = "MyProducts";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "المنتجات"),
    );
  }
}
