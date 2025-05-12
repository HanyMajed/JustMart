import 'dart:typed_data';

class ProductItemModel {
  final String vendorId;
  final String name;
  final String description;
  final String price;
  final String imageBase64;

  ProductItemModel({
    required this.vendorId,
    required this.name,
    required this.imageBase64,
    required this.description,
    required this.price,
  });

  toMap() {
    return {
      "vendorId": vendorId,
      'name': name,
      'description': description,
      'price': price,
      'imageBase64': imageBase64,
    };
  }

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      vendorId: map['vendorId'],
      name: map['name'],
      description: map['description'],
      price: (map['price']),
      imageBase64: map['imageBase64'],
    );
  }
}
