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
  String selectedCategory = 'الكل'; // Moved from global to state variable
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    _loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsView(
                              productItemModel: product,
                              signedUID: widget.signedUID,
                              productId: product.productId,
                            ),
                          ),
                        );
                      },
                      child: ItemProduct(
                        productImage: product.imageBase64,
                        productName: product.productName,
                        productPrice: product.price,
                      ),
                    );
                  },
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

      final tempProducts = querySnapshot.docs.map((doc) {
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
