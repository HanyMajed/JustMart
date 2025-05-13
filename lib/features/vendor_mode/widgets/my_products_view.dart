import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_card.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class MyProducts extends StatefulWidget {
  MyProducts({super.key, this.signedUID});
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
          : productItemModel == null
              ? const Center(child: Text('لم يتم العثور على المنتج'))
              : ListView.builder(
                  itemCount: productItems.length,
                  itemBuilder: ((context, index) {
                    return ProductItemCard(item: productItems[index]);
                  }),
                ),
    );
  }

  Future<void> getUserInfo(String uid) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

    try {
      DocumentSnapshot doc = await docRef.get();

      //retrive all the products ids of the user
      if (doc.exists) {
        for (int i = 0; i < doc['allProducts'].length; i++) {
          productIds.add(doc['allProducts'][i]);
          getProductInfo(doc['allProducts'][i]);
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
    String description, imageBase64, name, price, productCategory, vendorId;
    try {
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        name = doc.get('name');
        description = doc.get('description');
        imageBase64 = doc.get('imageBase64');
        price = doc.get('price');
        productCategory = doc.get('productCategory');
        vendorId = doc.get('vendorId');

        productItemModel = ProductItemModel(
          productCategory: productCategory,
          vendorId: vendorId,
          productName: name,
          imageBase64: imageBase64,
          description: description,
          price: price,
        );

        setState(() {
          productItems.add(productItemModel!);
        });
        log(" froom the created product object productItemModel:  ${productItemModel!.productName} \n");
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error getting document: $e');
    }
  }
}
