class UserEntity {
  String name;
  final String email;
  final String uId;
  String role;
  String phoneNumber;

  List<String> allProducts = [];
  List<String> allOrders = [];
  List<String> orderToDeliver = [];

  UserEntity({required this.name, required this.email, required this.uId, required this.role, required this.phoneNumber});

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'role': role,
      "phoneNumber": phoneNumber,
      'allProducts': [],
    };
  }
}
