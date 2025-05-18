import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

import 'package:just_mart/features/cart/cart_view.dart';
import 'package:just_mart/features/home/presentation/views/widgets/category_view.dart';

class CustomBottomNavigatonbar extends StatefulWidget {
  const CustomBottomNavigatonbar({super.key, required this.signedUID});
  final String signedUID;
  @override
  State<CustomBottomNavigatonbar> createState() => _CustomBottomNavigatonbarState();
}

class _CustomBottomNavigatonbarState extends State<CustomBottomNavigatonbar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 60,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 25,
            offset: Offset(0, -2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1), // light grey background
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                // Text
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'الحساب',
                      style: TextStyles.semiBold16,
                    ),
                  ),
                ),

                // Icon Circle
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 6),
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1D4F91), // dark blue color
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_box,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CartView();
              }));
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1), // light grey background
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.shopping_cart)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CategoryView(
                  signedUID: widget.signedUID,
                );
              }));
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1), // light grey background
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.category)),
          ),
        ],
      ),
    );
  }
}
