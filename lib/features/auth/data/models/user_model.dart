import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.uId,
    required super.role,
    required super.phoneNumber,
    //required super.emailVerified // Add this line
  });
  @override
  List<String> allProducts = [];
  @override
  List<String> allOrders = [];
  @override
  List<String> orderToDeliver = [];

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      role: "",
      phoneNumber: '',
      // emailVerified: user.emailVerified // Add this
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
