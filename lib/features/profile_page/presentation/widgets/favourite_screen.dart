import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/widgets/custom_appbar.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_card.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({super.key, required this.signedUId});
  static const routeName = 'favourite-screen';

  final String signedUId;

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late Future<List<Map<String, dynamic>>> favoriteProductsFuture;

  @override
  void initState() {
    super.initState();
    favoriteProductsFuture = fetchFavoriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'قائمة المفضله'),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: favoriteProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء تحميل المفضلة'));
          }

          final products = snapshot.data!;
          if (products.isEmpty) {
            return const Center(child: Text('لا توجد منتجات مفضلة'));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              // Decode Base64 image
              final String base64Image = product['imageBase64'] ?? '';
              final Uint8List imageBytes = base64Decode(base64Image);

              // Construct ProductItemModel
              final itemModel = ProductItemModel(
                productName: product['name'] ?? '',
                description: product['description'] ?? '',
                price: (product['price'] ?? 0).toString(),
                vendorId: product['vendorId'] ?? '',
                productCategory: product['productCategory'] ?? '',
                imageBase64: product['imageBase64'] ?? '',
              );

              return ProductItemCard(
                item: itemModel,
                imageBytes: imageBytes,
                hasIcon: false, // Set to true if you want the cart icon
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchFavoriteProducts() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final userDoc = await firestore.collection('users').doc(widget.signedUId).get();
      final List<dynamic> productIds = userDoc.data()?['favoriteProducts'] ?? [];

      log('Favorite product IDs: $productIds');

      List<Map<String, dynamic>> favoriteProducts = [];

      for (var productId in productIds) {
        final productDoc = await firestore.collection('products').doc(productId).get();
        if (productDoc.exists) {
          final data = productDoc.data()!;
          data['id'] = productDoc.id;
          favoriteProducts.add(data);
        }
      }

      return favoriteProducts;
    } catch (e) {
      log('Error fetching favorite products: $e');
      return [];
    }
  }
}
