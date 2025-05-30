import 'dart:convert';
import 'dart:typed_data';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

class ItemProduct extends StatefulWidget {
  ItemProduct({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productId,
    required this.signedUID,
    required this.isFavorite, // Added isFavorite parameter
  });

  final String productName, productPrice, productImage, productId, signedUID;
  final bool isFavorite; // Added to track initial favorite state

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  late IconData icon;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite; // Initialize with the passed value
    icon = isFavorite ? Icons.favorite : Icons.favorite_outline;
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? decodedImage;

    try {
      if (widget.productImage.isNotEmpty) {
        decodedImage = base64Decode(widget.productImage);
      }
    } catch (e) {
      debugPrint('Error decoding image: $e');
    }

    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F5F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 8,
            top: 8,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120, // Reduced image height
                  width: double.infinity,
                  child: decodedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.memory(
                            decodedImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildImageFallback();
                            },
                          ),
                        )
                      : _buildImageFallback(),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyles.bold13, // Reduced font size
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.productPrice,
                                  style: TextStyles.bold13.copyWith(
                                    color: AppColors.seconderyColor,
                                  ),
                                ),
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: 'JOD',
                                  style: TextStyles.bold13.copyWith(
                                    color: AppColors.seconderyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite; // Toggle the state
                            icon = isFavorite ? Icons.favorite : Icons.favorite_outline; // Set icon based on new state
                            if (isFavorite) {
                              addToFavorite(widget.signedUID, widget.productId);
                            } else {
                              delteFromFavorite(widget.signedUID, widget.productId);
                            }
                          });
                        },
                        child: Icon(
                          icon,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageFallback() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(
          Icons.image_not_supported,
          size: 40,
          color: Colors.grey,
        ),
      ),
    );
  }

  Future<void> addToFavorite(String uid, String productId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(uid).update({
        'favoriteProducts': FieldValue.arrayUnion([productId])
      });
    } catch (e) {
      log('failed to add product to favorite: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> delteFromFavorite(String uid, String productId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(uid).update({
        'favoriteProducts': FieldValue.arrayRemove([productId])
      });
    } catch (e) {
      log('failed to remove product from favorite: ${e.toString()}');
      rethrow;
    }
  }
}
