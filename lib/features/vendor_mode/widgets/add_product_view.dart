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
  List<String> categories = [
    "لوازم الدراسة",
    "التقنية والإلكترونيات",
    "الملابس والموضة",
    "الطعام والحلويات",
    "الترفيه والهوايات",
    "الإكسسوارات",
    "غيرها"
  ];
  var drpdownValue = 0;

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
                DropdownButtonFormField<int>(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  decoration: InputDecoration(
                      border:
                          OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10))),
                  dropdownColor: Colors.white.withAlpha(230),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text("لوازم الدراسة", style: TextStyle(color: AppColors.primaryColor))),
                    DropdownMenuItem(value: 1, child: Text("التقنية والإلكترونيات", style: TextStyle(color: AppColors.primaryColor))),
                    DropdownMenuItem(value: 2, child: Text("الملابس والموضة", style: TextStyle(color: AppColors.primaryColor))),
                    DropdownMenuItem(value: 3, child: Text("الطعام والحلويات", style: TextStyle(color: AppColors.primaryColor))),
                    DropdownMenuItem(value: 4, child: Text("الترفيه والهوايات", style: TextStyle(color: AppColors.primaryColor))),
                    DropdownMenuItem(value: 5, child: Text("الإكسسوارات", style: TextStyle(color: AppColors.primaryColor))),
                    DropdownMenuItem(value: 6, child: Text("غيرها", style: TextStyle(color: AppColors.primaryColor))),
                  ],
                  value: drpdownValue,
                  onChanged: (newValue) {
                    setState(() {
                      drpdownValue = newValue!;
                    });
                  },
                ),
                _buildLabel("السعر:"),
                TextFormField(
                  decoration: _inputDecoration("السعر"),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    price = value!;
                    price = convertArabicToEnglish(price!);
                  },
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
                      backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
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
        productCategory: categories[drpdownValue],
        vendorId: widget.signedUID!,
        productName: name ?? 'name was null',
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
      var docRef = await FirebaseFirestore.instance.collection(BackendEndpoints.addProduct).add(
            productItemModel!.toMap(),
          );
      await docRef.update({'productId': docRef.id});
      log('thee document ref is ${docRef.id}');

      addProductIdToUser(userId: widget.signedUID!, productId: docRef.id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت إضافة المنتج بنجاح')),
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      log('Error adding product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء إضافة المنتج')),
      );
    }
  }

  Future<void> addProductIdToUser({required String userId, required String productId}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add the product ID to the user's productIds list
      await firestore.collection(BackendEndpoints.addUserData).doc(userId).update({
        'allProducts': FieldValue.arrayUnion([productId]),
      });

      debugPrint('Product ID added to user successfully');
    } catch (e) {
      debugPrint('Error adding product ID to user: $e');
    }
  }

  String convertArabicToEnglish(String input) {
    const arabicNums = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishNums = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    for (int i = 0; i < arabicNums.length; i++) {
      input = input.replaceAll(arabicNums[i], englishNums[i]);
    }

    return input;
  }
}
