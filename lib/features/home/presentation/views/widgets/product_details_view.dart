import 'dart:convert';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/bottom_curve_clipper.dart';
import 'package:just_mart/features/home/presentation/views/widgets/quantity_selector.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/widgets/custom_button.dart';

class ProductDetailsView extends StatefulWidget {
  ProductDetailsView({super.key, required this.productItemModel});
  static const String routeName = "ProductDetailsView";
  final ProductItemModel productItemModel;
  var decodedImage;
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    widget.decodedImage = base64Decode(widget.productItemModel.imageBase64);
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
                    Text(
                      widget.productItemModel.description,
                      style: TextStyles.regular13.copyWith(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 175,
                child: CustomButton(onPressed: () {}, text: 'اضافة الى السلة'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
