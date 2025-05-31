import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/vendor_mode/widgets/vendor_items_grid_display.dart';

class VendorNameCard extends StatefulWidget {
  const VendorNameCard({
    super.key,
    required this.vendor,
    required this.signedUID,
  });

  final UserEntity vendor;
  final String signedUID;

  @override
  State<VendorNameCard> createState() => _VendorNameCardState();
}

class _VendorNameCardState extends State<VendorNameCard> {
  String? base64Image;
  bool isLoading = true;
  int productCount = 0;

  @override
  void initState() {
    super.initState();
    _loadVendorData();
  }

  @override
  void didUpdateWidget(VendorNameCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.vendor.uId != widget.vendor.uId) {
      _resetAndReload();
    }
  }

  void _resetAndReload() {
    setState(() {
      isLoading = true;
      base64Image = null;
      productCount = 0;
    });
    _loadVendorData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VendorItemsGridDisplay(
              signedUID: widget.signedUID,
              vendor: widget.vendor,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildImageBox(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.vendor.name,
                    style: TextStyles.bold19.copyWith(color: AppColors.primaryColor),
                  ),
                  Text(
                    widget.vendor.phoneNumber,
                    style: TextStyles.semiBold16.copyWith(color: Colors.grey.shade700),
                  ),
                  Text(
                    '$productCount منتجات',
                    style: TextStyles.bold13.copyWith(color: Colors.grey.shade800),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageBox() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: isLoading
            ? _buildPlaceholderIcon()
            : (base64Image != null
                ? Image.memory(
                    base64Decode(base64Image!),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildDefaultAssetImage();
                    },
                  )
                : _buildDefaultAssetImage()),
      ),
    );
  }

  Widget _buildDefaultAssetImage() {
    return Image.asset(
      'assets/images/vendor.png',
      fit: BoxFit.cover,
    );
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      color: Colors.grey.shade300,
      child: const Icon(Icons.store, size: 40, color: Colors.grey),
    );
  }

  Future<void> _loadVendorData() async {
    try {
      final results = await Future.wait([
        _getFirstProductImageForVendor(),
        _fetchVendorProductCount(),
      ]);

      setState(() {
        base64Image = results[0] as String?;
        productCount = results[1] as int;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading vendor data: $e');
      setState(() => isLoading = false);
    }
  }

  Future<String?> _getFirstProductImageForVendor() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('products').where('vendorId', isEqualTo: widget.vendor.uId).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final productData = querySnapshot.docs.first.data();
        return productData['imageBase64'] as String?;
      }
      return null;
    } catch (e) {
      print('Error fetching product image: $e');
      return null;
    }
  }

  Future<int> _fetchVendorProductCount() async {
    int count = 0;

    try {
      final aggregateQuery = FirebaseFirestore.instance.collection('products').where('vendorId', isEqualTo: widget.vendor.uId).count();

      final aggregateSnapshot = await aggregateQuery.get();
      count = aggregateSnapshot.count!;
    } catch (e) {
      print('Error fetching product count: $e');
    }

    return count;
  }
}
