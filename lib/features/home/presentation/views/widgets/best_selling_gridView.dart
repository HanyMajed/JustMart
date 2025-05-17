import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/home/presentation/views/widgets/product_details_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/widgets/item_product.dart';

class BestSellingGridview extends StatefulWidget {
  const BestSellingGridview({super.key, required this.signedUID});
  final String signedUID;

  @override
  State<BestSellingGridview> createState() => _BestSellingGridviewState();
}

class _BestSellingGridviewState extends State<BestSellingGridview> {
  List<ProductItemModel> allProducts = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return SliverToBoxAdapter(
        child: Center(child: Text(error!)),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 200,
        crossAxisCount: 2,
        childAspectRatio: 163 / 214,
        mainAxisSpacing: 8,
        crossAxisSpacing: 16,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsView(productItemModel: allProducts[index], signedUID: widget.signedUID),
                ),
              );
            },
            child: ItemProduct(
              productImage: allProducts[index].imageBase64,
              productName: allProducts[index].productName,
              productPrice: allProducts[index].price,
            ),
          );
        },
        childCount: allProducts.length,
      ),
    );
  }

  Future<void> getAllProducts() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(BackendEndpoints.addProduct).get();

      List<ProductItemModel> tempProducts = querySnapshot.docs.map((doc) {
        return ProductItemModel(
          productCategory: doc['productCategory'] ?? '',
          vendorId: doc['vendorId'] ?? '',
          productName: doc['name'] ?? '',
          imageBase64: doc['imageBase64'] ?? '',
          description: doc['description'] ?? '',
          price: doc['price'] ?? '0',
        );
      }).toList();

      setState(() {
        allProducts = tempProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
      print('Error fetching products: $e');
    }
  }
}
