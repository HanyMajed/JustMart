import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/auth/data/domain/entities/user_entity.dart';
import 'package:just_mart/features/cart/cart_deleting_icon_alert.dart';
import 'package:just_mart/features/home/presentation/views/widgets/custom_bottom_navigatonbar.dart';
import 'package:just_mart/features/home/presentation/views/widgets/vendor_gridView.dart';

class VendorItemsGridDisplay extends StatelessWidget {
  const VendorItemsGridDisplay({super.key, required this.signedUID, required this.vendor});
  final String signedUID;
  final UserEntity vendor;
  @override
  Widget build(BuildContext context) {
    log(vendor.name);

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigatonbar(
        signedUID: signedUID,
      ),
      appBar: AppBar(
        title: Text(
          "منتجات ${vendor.name}",
          style: TextStyles.bold19,
        ),
        leading: const CartDeletingIconAlert(),
      ),
      body: VendorGridView(signedUID: signedUID, vendor: vendor),
    );
  }
}
