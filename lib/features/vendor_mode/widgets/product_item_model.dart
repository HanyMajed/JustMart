class ProductItemModel {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
  });
}
