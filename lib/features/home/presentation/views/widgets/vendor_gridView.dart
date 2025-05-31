import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/home/presentation/views/widgets/custom_bottom_navigatonbar.dart';
import 'package:just_mart/features/home/presentation/views/widgets/product_details_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/widgets/item_product.dart';
import 'package:just_mart/features/category/category_view.dart';

class VendorGridView extends StatefulWidget {
  const VendorGridView({super.key, required this.signedUID, required this.vendor});
  final String signedUID;
  final UserEntity vendor;

  @override
  State<VendorGridView> createState() => _VendorGridViewState();
}

class _VendorGridViewState extends State<VendorGridView> {
  List<ProductItemModel> vendorProducts = [];
  List<String> productIds = [];
  List<String> favoriteProductIds = []; // To store user's favorite product IDs

  String selectedCategory = 'الكل';
  bool isLoading = true;
  String? error;
  String productId = '';

  @override
  void initState() {
    _loadUserFavorites(); // Load user favorites first
    super.initState();
  }

  Future<void> _loadUserFavorites() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(widget.signedUID).get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data.containsKey('favoriteProducts')) {
          setState(() {
            favoriteProductIds = List<String>.from(data['favoriteProducts'] ?? []);
          });
        }
      }
      await _loadProducts(); // After loading favorites, load products
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back gesture & back button

      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigatonbar(
          signedUID: widget.signedUID,
          onCategorySelected: (category) {
            setState(() {
              selectedCategory = category;
            });
            _loadProducts();
          },
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : vendorProducts.isEmpty
                ? const Center(child: Text('لا توجد منتجات متاحة'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: vendorProducts.length,
                    itemBuilder: (context, index) {
                      final product = vendorProducts[index];
                      final productId = productIds[index];
                      final isFavorite = favoriteProductIds.contains(productId); // Check if product is favorite

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsView(
                                productItemModel: product,
                                signedUID: widget.signedUID,
                                productId: productId,
                              ),
                            ),
                          );
                        },
                        child: ItemProduct(
                          signedUID: widget.signedUID,
                          productId: productId,
                          productImage: product.imageBase64,
                          productName: product.productName,
                          productPrice: product.price,
                          isFavorite: isFavorite, // Pass the favorite status
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Future<void> _loadProducts() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      Query query = FirebaseFirestore.instance.collection(BackendEndpoints.addProduct).where('vendorId', isEqualTo: widget.vendor.uId);

      if (selectedCategory != "الكل") {
        query = query.where('productCategory', isEqualTo: selectedCategory);
      }

      final querySnapshot = await query.get();
      productIds.clear();
      final tempProducts = querySnapshot.docs.map((doc) {
        productIds.add(doc.id);
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
        vendorProducts = tempProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _openCategorySelection() async {
    final selected = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryView(signedUID: widget.signedUID),
      ),
    );

    if (selected != null && selected is String) {
      setState(() {
        selectedCategory = selected;
      });
      await _loadProducts();
    }
  }
}
