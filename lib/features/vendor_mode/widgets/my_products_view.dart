import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_card.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({super.key, this.signedUID});
  final String? signedUID;
  static const String routeName = "MyProducts";
  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  ProductItemModel? productItemModel;
  bool isLoading = true;
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
      appBar: appbarForVendorViews(title: "المنتجات"),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : productItems.isEmpty
              ? const Center(child: Text('لم يتم العثور على المنتجات'))
              : ListView.builder(
                  itemCount: productItems.length,
                  itemBuilder: ((context, index) {
                    // Decode the image for each product when building the card
                    final imageBytes = base64Decode(productItems[index].imageBase64);
                    return ProductItemCard(
                      item: productItems[index],
                      imageBytes: imageBytes,
                    );
                  }),
                ),
    );
  }

  Future<void> getUserInfo(String uid) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

    try {
      DocumentSnapshot doc = await docRef.get();

      //retrieve all the products ids of the user
      if (doc.exists) {
        productIds.clear(); // Clear previous IDs
        productItems.clear(); // Clear previous items

        if (doc['allProducts'] != null) {
          for (int i = 0; i < doc['allProducts'].length; i++) {
            productIds.add(doc['allProducts'][i]);
            await getProductInfo(doc['allProducts'][i]);
          }
        }
        log("product items list contains:  $productItems \n");
        log("all product ids list:  $productIds \n");
      } else {
        log('User with UID $uid not found.');
      }
    } catch (e) {
      log('Error fetching user: $e');
    }

    setState(() {
      isLoading = false;
    });
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
