import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/home/presentation/views/widgets/bottom_curve_clipper.dart';
import 'package:just_mart/features/home/presentation/views/widgets/quantity_selector.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/widgets/custom_button.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.signedUID});
  static const String routeName = "ProductDetailsView";
  final String? signedUID;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
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
                  Image.asset(Assets.assetsImagesShoes),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "اسم المنتج",
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
                            "3",
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
                      "هنا سيتم وضع الوصف لكل منتج سوف يتم عرضه في اللائحةوهنا سيتم وضع الوصف لكل منتج سوف يتم عرضه في اللائحةهنا سيتم وضع الوصف لكل منتج سوف يتم عرضه في اللائحة",
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
