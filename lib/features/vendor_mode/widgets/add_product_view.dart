import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/pick_image.dart';
import 'package:just_mart/widgets/custom_text_form_field.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});
  static const String routeName = "AddProduct";

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Uint8List? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "إضافة منتج"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اسم المنتج:',
                  style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomTextFormField(hintText: "اسم المنتج"),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'وصف المنتج:',
                  style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomTextFormField(hintText: "وصف المنتج"),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'السعر:',
                  style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomTextFormField(hintText: "السعر"),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'صورة المنتج:',
                  style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: img != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.memory(
                              img!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.image,
                            size: 100,
                            color: AppColors.primaryColor,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void selectImage() async {
    final image = await pickImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        img = image;
      });
      debugPrint('Image selected successfully');
    } else {
      debugPrint('No image selected');
    }
  }
}
