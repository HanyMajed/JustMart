import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/pick_image.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/widgets/custom_text_form_field.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key, this.signedUID});
  static const String routeName = "AddProduct";
  final String? signedUID;

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  ProductItemModel? productItemModel;

  final _formKey = GlobalKey<FormState>();
  Uint8List? img;
  String? vendorId;
  String? name;
  String? description;
  String? price;
  String? imageBase64;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "إضافة منتج"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("اسم المنتج:"),
                TextFormField(
                  decoration: _inputDecoration("اسم المنتج"),
                  onSaved: (value) => name = value!,
                ),
                const SizedBox(height: 8),
                _buildLabel("وصف المنتج:"),
                TextFormField(
                  decoration: _inputDecoration("وصف المنتج"),
                  onSaved: (value) => description = value!,
                ),
                const SizedBox(height: 8),
                _buildLabel("السعر:"),
                TextFormField(
                  decoration: _inputDecoration("السعر"),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => price = value!,
                ),
                const SizedBox(height: 8),
                _buildLabel("صورة المنتج:"),
                GestureDetector(
                  onTap: selectImage,
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
                            child: Image.memory(img!, fit: BoxFit.cover),
                          )
                        : const Icon(Icons.image, size: 100, color: AppColors.primaryColor),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                    ),
                    child: Text("اضافة", style: TextStyles.semiBold16.copyWith(color: Colors.white)),
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
        imageBase64 = base64Encode(img!);
      });
      debugPrint('Image selected successfully');
    } else {
      debugPrint('No image selected');
    }
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      productItemModel = ProductItemModel(
        vendorId: widget.signedUID!,
        name: name ?? 'name was null',
        imageBase64: imageBase64 ?? 'image was null',
        description: description ?? 'description was null',
        price: price ?? 'price was null',
      );
      productItemModel = productItemModel;
      addProductToFirebase();

      //  log('${productItemModel!.name}  ${productItemModel!.description}   ${productItemModel!.price}   ${productItemModel!.imageBase64}');
    }
  }

  void addProductToFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await FirebaseFirestore.instance.collection(BackendEndpoints.addProduct).add(
            productItemModel!.toMap(),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تمت إضافة المنتج بنجاح')),
      );

      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      log('Error adding product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء إضافة المنتج')),
      );
    }
  }
}
