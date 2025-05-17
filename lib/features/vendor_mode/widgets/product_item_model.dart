class ProductItemModel {
  final String vendorId;
  final String productCategory;
  final String productName;
  final String description;
  final String price;
  final String imageBase64;
  int quantity = 0;
  String productId = "";

  ProductItemModel({
    required this.productCategory,
    required this.vendorId,
    required this.productName,
    required this.imageBase64,
    required this.description,
    required this.price,
  });

  toMap() {
    return {
      "vendorId": vendorId,
      'name': productName,
      'description': description,
      'price': price,
      'imageBase64': imageBase64,
      'productCategory': productCategory
    };
  }

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      vendorId: map['vendorId'],
      productName: map['name'],
      description: map['description'],
      price: (map['price']),
      imageBase64: map['imageBase64'],
      productCategory: 'productCategory',
    );
  }
}
