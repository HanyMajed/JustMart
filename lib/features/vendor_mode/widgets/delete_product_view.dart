import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_card.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class DeleteProductView extends StatefulWidget {
  const DeleteProductView({super.key, this.signedUID});
  final String? signedUID;
  static const String routeName = "MyProducts";
  @override
  State<DeleteProductView> createState() => _DeleteProductViewState();
}

class _DeleteProductViewState extends State<DeleteProductView> {
  ProductItemModel? productItemModel;
  bool isLoading = true;
  bool isDeleting = false;
  List<String> productIds = [];
  List<ProductItemModel> productItems = [];

  @override
  void initState() {
    super.initState();
    getUserInfo(widget.signedUID!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForVendorViews(title: "حذف منتج"),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : productItems.isEmpty
              ? const Center(child: Text('لم يتم العثور على المنتجات'))
              : ListView.builder(
                  itemCount: productItems.length,
                  itemBuilder: ((context, index) {
                    final imageBytes = base64Decode(productItems[index].imageBase64);
                    return GestureDetector(
                      onTap: () async {
                        log(productIds[index]);
                        await deleteProductById(productIds[index]);
                      },
                      child: ProductItemCard(
                        item: productItems[index],
                        imageBytes: imageBytes,
                      ),
                    );
                  }),
                ),
    );
  }

  Future<void> getUserInfo(String uid) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

    try {
      DocumentSnapshot doc = await docRef.get();
      productIds.clear();
      productItems.clear();

      if (doc.exists && doc['allProducts'] != null) {
        for (int i = 0; i < doc['allProducts'].length; i++) {
          productIds.add(doc['allProducts'][i]);
          await getProductInfo(doc['allProducts'][i]);
        }
        log("product items list contains:  $productItems \n");
        log("all product ids list:  $productIds \n");
      } else {
        log('User with UID $uid not found or has no products.');
      }
    } catch (e) {
      log('Error fetching user: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteProductById(String productId) async {
    setState(() {
      isDeleting = true;
    });

    // Show progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).delete();
      await deleteProductFromUser(widget.signedUID!, productId);

      // Update local list and refresh UI
      int index = productIds.indexOf(productId);
      if (index != -1) {
        productItems.removeAt(index);
        productIds.removeAt(index);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حذف المنتج بنجاح')),
      );
    } catch (e) {
      print('Error deleting product: $e');
    }

    Navigator.of(context).pop(); // Close progress dialog

    setState(() {
      isDeleting = false;
    });
  }

  Future<void> deleteProductFromUser(String uid, String productId) async {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
    try {
      await userDocRef.update({
        'allProducts': FieldValue.arrayRemove([productId])
      });
    } catch (e) {
      print('Error removing product ID: $e');
    }
  }

  Future<void> getProductInfo(String productId) async {
    final docRef = FirebaseFirestore.instance.collection(BackendEndpoints.addProduct).doc(productId);
    try {
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        final productItemModel = ProductItemModel(
          productCategory: doc.get('productCategory'),
          vendorId: doc.get('vendorId'),
          productName: doc.get('name'),
          imageBase64: doc.get('imageBase64'),
          description: doc.get('description'),
          price: doc.get('price'),
        );

        setState(() {
          productItems.add(productItemModel);
        });
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error getting document: $e');
    }
  }
}
