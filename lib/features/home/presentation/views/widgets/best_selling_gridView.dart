import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_mart/features/home/presentation/views/widgets/product_details_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
import 'package:just_mart/widgets/item_product.dart';
import 'package:just_mart/main.dart'; // 👈 Import where routeObserver is defined

String selectedCategory = 'الكل';

class BestSellingGridview extends StatefulWidget {
  const BestSellingGridview({super.key, required this.signedUID});
  final String signedUID;

  @override
  State<BestSellingGridview> createState() => _BestSellingGridviewState();
}

class _BestSellingGridviewState extends State<BestSellingGridview> with RouteAware {
  List<ProductItemModel> productsWithCategory = [];
  List<ProductItemModel> allproducts = [];

  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchProductsBasedOnCategory();
  }

  void fetchProductsBasedOnCategory() {
    if (selectedCategory == 'الكل') {
      getAllProducts();
    } else {
      getProductsByCategory(selectedCategory);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 👇 Subscribe to route changes
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // 👇 Unsubscribe when done
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // 👇 Called when this screen is visible again (after popping from CategoryView)
  @override
  void didPopNext() {
    setState(() {
      fetchProductsBasedOnCategory();
    });
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

    List<ProductItemModel> displayedProducts = selectedCategory == 'الكل' ? allproducts : productsWithCategory;

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
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsView(
                    productItemModel: displayedProducts[index],
                    signedUID: widget.signedUID,
                    productId: displayedProducts[index].productId,
                  ),
                ),
              );
              if (result == 'refresh') {
                setState(() {
                  fetchProductsBasedOnCategory();
                });
              }
            },
            child: ItemProduct(
              productImage: displayedProducts[index].imageBase64,
              productName: displayedProducts[index].productName,
              productPrice: displayedProducts[index].price,
            ),
          );
        },
        childCount: displayedProducts.length,
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
        allproducts = tempProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> getProductsByCategory(String categoryName) async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(BackendEndpoints.addProduct).where('productCategory', isEqualTo: categoryName).get();

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
        productsWithCategory = tempProducts;
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
