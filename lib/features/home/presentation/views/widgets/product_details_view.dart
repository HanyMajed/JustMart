import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/home/presentation/views/widgets/bottom_curve_clipper.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.signedUID});
  static const String routeName = "ProductDetailsView";
  final String? signedUID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Curved background
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  height: 350,
                  width: double.infinity,
                  color: const Color(0xFFF6F8FA),
                ),
              ),
              Image.asset(Assets.assetsImagesShoes),
            ],
          ),
          const Text("product name", style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
