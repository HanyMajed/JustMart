import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.uId, required super.role});
  @override
  List<String> allProducts = [];

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      role: "",
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uId: json['uId'],
      role: json['role'],
    );
  }
}
