import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class ProductItemCard extends StatefulWidget {
  const ProductItemCard({
    super.key,
    this.hasIcon = false,
    required this.item,
    required this.imageBytes,
  });

  final ProductItemModel item;
  final Uint8List imageBytes;
  final bool hasIcon;
  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  String? vendorName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getVendorName();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          // Changed from Column to Row
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image - now on the left side
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16), // Adjusted border radius
              ),
              child: Image.memory(
                widget.imageBytes,
                height: 150,
                width: 175, // Fixed width instead of infinity
                fit: BoxFit.cover,
              ),
            ),

            // Info section - now takes remaining space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      widget.item.productName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Description
                    Text(
                      widget.item.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Vendor Name
                    isLoading
                        ? const SizedBox(
                            height: 20,
                            child: Center(
                              child: SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          )
                        : Text(
                            vendorName ?? 'Unknown Vendor',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    const SizedBox(height: 8),

                    // Price & Cart Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.item.price} JOD',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        widget.hasIcon
                            ? const Icon(
                                Icons.add_shopping_cart_outlined,
                                color: AppColors.primaryColor,
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getVendorName() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(widget.item.vendorId);
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        setState(() {
          vendorName = doc.get('name');
          isLoading = false;
        });
      } else {
        setState(() {
          vendorName = 'Unknown Vendor';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        vendorName = 'Error loading vendor';
        isLoading = false;
      });
      print('Error getting vendor name: $e');
    }
  }
}
