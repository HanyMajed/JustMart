import 'package:just_mart/features/vendor_mode/widgets/product_item_card.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class UserEntity {
  String name;
  final String email;
  final String uId;
  String role;
  List<ProductItemModel> allProducts = [];
  UserEntity({required this.name, required this.email, required this.uId, required this.role});

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'role': role,
    };
  }
}
