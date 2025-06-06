import 'package:flutter/material.dart';
import 'package:just_mart/features/vendor_mode/presentation/views/vendor_menu_view.dart';

class VendorIconWidget extends StatelessWidget {
  const VendorIconWidget({
    super.key,
    required this.signedUID,
  });
  final String signedUID;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return VendorMenuview(
            signedUID: signedUID,
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: const ShapeDecoration(shape: OvalBorder(), color: Color.fromRGBO(31, 61, 120, 0.2) // 50% transparent
            ),
        child: const Icon(Icons.storefront_outlined),
      ),
    );
  }
}
