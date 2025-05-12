import 'package:flutter/material.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});
  static const String routeName = "AddProduct";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "إضافة منتج"),
    );
  }
}
