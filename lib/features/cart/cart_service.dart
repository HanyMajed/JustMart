import 'package:flutter/material.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();
}
