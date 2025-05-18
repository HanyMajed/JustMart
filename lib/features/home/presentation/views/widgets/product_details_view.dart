import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/cart/cart_provider.dart';
import 'package:just_mart/features/home/presentation/views/widgets/bottom_curve_clipper.dart';
import 'package:just_mart/features/home/presentation/views/widgets/quantity_selector.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/widgets/custom_button.dart';

class ProductDetailsView extends StatefulWidget {
  ProductDetailsView({super.key, required this.productItemModel, required this.signedUID, required this.productId});
  static const String routeName = "ProductDetailsView";
  final ProductItemModel productItemModel;
  var decodedImage;
  final String signedUID;
  final String productId;
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  String? userName;
  bool isLoading = true;

  @override
  void initState() {
    widget.decodedImage = base64Decode(widget.productItemModel.imageBase64);
    getUserName(widget.signedUID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "عرض المنتج"),
      body: ListView(
        children: [
          Column(
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
                      color: const Color.fromARGB(255, 214, 214, 214),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.memory(
                      widget.decodedImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.productItemModel.productName,
                        style: TextStyles.bold19.copyWith(color: Colors.grey.shade800),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.productItemModel.description,
                      style: TextStyles.regular13.copyWith(color: Colors.grey.shade600),
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              userName ?? 'Unknown User', // Safe null handling
                              style: TextStyles.regular13.copyWith(color: Colors.grey.shade600),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            "JOD ",
                            style: TextStyles.semiBold16.copyWith(color: AppColors.seconderyColor),
                          ),
                          Text(
                            widget.productItemModel.price,
                            style: TextStyles.semiBold16.copyWith(color: AppColors.seconderyColor),
                          ),
                          const Spacer(),
                          QuantitySelector(
                            initialValue: 1,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 175,
                child: CustomButton(
                  onPressed: () {
                    final product = ProductItemModel(
                      productCategory: widget.productItemModel.productCategory,
                      vendorId: widget.productItemModel.vendorId,
                      productName: widget.productItemModel.productName,
                      description: widget.productItemModel.description,
                      price: widget.productItemModel.price,
                      imageBase64: widget.productItemModel.imageBase64,
                    );
                    product.productId = widget.productId;
                    context.read<CartProvider>().addToCart(product);
                    Navigator.pop(context);
                  },
                  text: 'اضافة الى السلة',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getUserName(String Uid) async {
    final docRef = FirebaseFirestore.instance.collection(BackendEndpoints.addUserData).doc(Uid);
    try {
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        setState(() {
          userName = doc.get('name');
          isLoading = false;
        });
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error getting document: $e');
    }
  }
}
