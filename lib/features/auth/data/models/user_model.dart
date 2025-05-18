import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/orders/order_model.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.uId, required super.role, required super.phoneNumber});
  @override
  List<String> allProducts = [];
  List<String> allOrders = [];

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      role: "",
      phoneNumber: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uId: json['uId'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
