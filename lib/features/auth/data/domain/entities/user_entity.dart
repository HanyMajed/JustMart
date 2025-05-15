class UserEntity {
  String name;
  final String email;
  final String uId;
  String role;
  List<String> allProducts = [];

  UserEntity({required this.name, required this.email, required this.uId, required this.role});

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'role': role,
      'allProducts': [],
    };
  }
}
