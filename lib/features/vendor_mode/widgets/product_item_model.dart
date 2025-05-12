class ProductItemModel {
  final String vendorId;
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  ProductItemModel({
    required this.vendorId,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
  });
}
