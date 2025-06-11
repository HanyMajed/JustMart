import 'dart:developer';

import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class CartModel {
  String id; // product ID
  String title;
  double totalPrice;
  List<ProductItemModel> cartItems = [];

  double getTotalPrice() {
    for (var item in cartItems) {
      double itemPrice = double.parse(item.price);
      totalPrice += itemPrice * item.quantity;
    }
    return totalPrice;
  }

  CartModel({
    required this.id,
    required this.title,
    required this.totalPrice,
  });
}
