import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:just_mart/constants.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/auth/data/models/user_model.dart';
import 'package:just_mart/features/home/presentation/views/widgets/custom_home_appbar.dart';
import 'package:just_mart/features/home/presentation/views/widgets/featured_list.dart';
import 'package:just_mart/features/home/presentation/views/widgets/search_text_field.dart';
import 'package:just_mart/features/vendor_mode/widgets/vendor_name_card.dart';

class HomeViewBody extends StatefulWidget {
  HomeViewBody({super.key, required this.signedUID, this.title = "كل المنتجات"});
  final String signedUID;
  String title;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  List<UserEntity> users = [];
  List<UserEntity> filteredUsers = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getAllVendors();
    super.initState();
  }

  void filterVendors(String query) {
    setState(() {
      filteredUsers = users.where((vendor) => vendor.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizantalPadding),
            child: Column(
              children: [
                const SizedBox(height: kTopPadding),
                CustomHomeAppbar(signedUID: widget.signedUID),
                const SizedBox(height: kTopPadding),
                FeaturedList(),
                const SizedBox(height: 12),
                SearchTextfield(
                  controller: searchController,
                  onChanged: filterVendors,
                ),
                const SizedBox(height: 12),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "قائمة البائعين",
                    style: TextStyles.bold16,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: List.generate(
                    searchController.text.isEmpty ? users.length : filteredUsers.length,
                    (index) => VendorNameCard(
                      signedUID: widget.signedUID,
                      vendor: searchController.text.isEmpty ? users[index] : filteredUsers[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getAllVendors() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot usersSnapshot = await firestore.collection('users').where('role', isEqualTo: 'vendor').get();

      setState(() {
        users = usersSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return UserModel.fromJson(data);
        }).toList();
        filteredUsers = users;
      });
    } catch (e) {
      log('Error getting vendors: $e');
      throw Exception('Failed to get vendors');
    }
  }
}
