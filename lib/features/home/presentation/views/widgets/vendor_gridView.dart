import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/home/presentation/views/widgets/product_details_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/widgets/item_product.dart';
import 'package:just_mart/main.dart'; // 👈 Import where routeObserver is defined

String selectedCategory = 'الكل';

class VendorGridView extends StatefulWidget {
  const VendorGridView({super.key, required this.signedUID, required this.vendor});
  final String signedUID;
  final UserEntity vendor;

  @override
  State<VendorGridView> createState() => _VendorGridViewState();
}

class _VendorGridViewState extends State<VendorGridView> with RouteAware {
  List<ProductItemModel> productsWithCategory = [];
  List<ProductItemModel> vendorProducts = [];

  bool isLoading = true;
  String? error;

  @override
  void initState() {
    getVendorProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (vendorProducts.isEmpty) {
      return const Center(child: Text('No products available'));
    }
    return isLoading
        ? const Center(child: CircularProgressIndicator())
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
          );
  }

  Future<void> getVendorProducts() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(BackendEndpoints.addProduct).where('vendorId', isEqualTo: widget.vendor.uId).get();

      List<ProductItemModel> tempProducts = querySnapshot.docs.map((doc) {
        var product = ProductItemModel(
          productCategory: doc['productCategory'] ?? '',
          vendorId: doc['vendorId'] ?? '',
          productName: doc['name'] ?? '',
          imageBase64: doc['imageBase64'] ?? '',
          description: doc['description'] ?? '',
          price: doc['price'] ?? '0',
        );
        product.productId = doc.id;
        return product;
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
}
