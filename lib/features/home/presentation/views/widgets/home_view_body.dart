import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:just_mart/constants.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/auth/data/models/user_model.dart';
import 'package:just_mart/features/home/presentation/views/widgets/vendor_gridView.dart';
import 'package:just_mart/features/home/presentation/views/widgets/best_selling_header.dart';
import 'package:just_mart/features/home/presentation/views/widgets/custom_home_appbar.dart';
import 'package:just_mart/features/home/presentation/views/widgets/featured_list.dart';
import 'package:just_mart/features/home/presentation/views/widgets/search_text_field.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';
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

  @override
  void initState() {
    getAllVendors();

    super.initState();
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
                const SearchTextfield(),
                const SizedBox(height: 12),
                Column(
                  children: List.generate(
                    users.length,
                    (index) => VendorNameCard(
                      signedUID: widget.signedUID,
                      vendor: users[index],
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
      // Add where clause to filter by role
      QuerySnapshot usersSnapshot = await firestore
          .collection('users')
          .where('role', isEqualTo: 'vendor') // Filter for vendor role
          .get();

      setState(() {
        users = usersSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return UserModel.fromJson(data);
        }).toList();
      });
    } catch (e) {
      log('Error getting vendors: $e');
      throw Exception('Failed to get vendors');
    }
  }
}
