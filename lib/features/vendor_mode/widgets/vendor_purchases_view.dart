import 'package:flutter/material.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';

class VendorPurchases extends StatelessWidget {
  const VendorPurchases({super.key});

  static const String routeName = "VendorPurchases";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "المشتريات"),
    );
  }
}
