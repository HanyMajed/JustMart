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

// This widget displays the main body of the Home View for the app.
// It shows a custom app bar, featured product list, search field,
// and a dynamically updated list of vendors (users with role 'vendor').
// The vendor data is fetched from Firestore and can be refreshed using pull-to-refresh.
// The list of vendors can be filtered live using the search bar.

class _HomeViewBodyState extends State<HomeViewBody> {
  List<UserEntity> users = [];
  List<UserEntity> filteredUsers = [];
  final TextEditingController searchController = TextEditingController();
  bool isFetching = false;

  @override
  void initState() {
    getAllVendors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(
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
                  if (isFetching)
                    const Center(child: CircularProgressIndicator())
                  else
                    Column(
                      children: List.generate(
                        filteredUsers.length,
                        (index) => VendorNameCard(
                          key: ValueKey(filteredUsers[index].uId), // Unique key
                          signedUID: widget.signedUID,
                          vendor: filteredUsers[index],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getAllVendors() async {
    setState(() => isFetching = true);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot usersSnapshot = await firestore.collection('users').where('role', isEqualTo: 'vendor').get();

      setState(() {
        users = usersSnapshot.docs.map((doc) {
          return UserModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
        filteredUsers = List.from(users);
        isFetching = false;
      });
    } catch (e) {
      log('Error getting vendors: $e');
      setState(() => isFetching = false);
    }
  }

  Future<void> _onRefresh() async {
    await getAllVendors();
  }

  void filterVendors(String query) {
    if (query.isEmpty) {
      setState(() => filteredUsers = List.from(users));
    } else {
      setState(() {
        filteredUsers = users.where((vendor) => vendor.name.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }
}
