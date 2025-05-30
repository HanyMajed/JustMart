class UserEntity {
  String name;
  final String email;
  final String uId;
  String role;
  String phoneNumber;

  // bool emailVerified; // New field

  List<String> allProducts = [];
  List<String> allOrders = [];
  List<String> orderToDeliver = [];
  List<String> favoriteProducts = [];

  UserEntity({
    required this.name,
    required this.email,
    required this.uId,
    required this.role,
    required this.phoneNumber,
    //  required this.emailVerified // Add this
  });

  toMap() {
    return {
      // 'emailVerified': emailVerified, // Add this
      'name': name,
      'email': email,
      'uId': uId,
      'role': role,
      "phoneNumber": phoneNumber,
      'allProducts': [],
      'favoriteProducts': [],
    };
  }
}
