import 'package:flutter/material.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<ProductItemModel> _items = [];

  List<ProductItemModel> get items => _items;
  double get total => _items.fold(
        0,
        (sum, item) => sum + double.parse(item.price) * item.quantity,
      );
  void addToCart(ProductItemModel product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((item) => item.productId == product.productId);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(product);
    }
  }

  void removeItem(ProductItemModel product) {
    _items.removeWhere((item) => item.productId == product.productId);
  }

  void updateQuantity(String productId, int newQuantity) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      _items[index].quantity = newQuantity;
    }
  }
}
