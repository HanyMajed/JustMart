import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_images.dart';
import 'package:just_mart/features/vendor_mode/widgets/appbar_for_vendor_views.dart';
import 'package:just_mart/features/vendor_mode/widgets/product_item_model.dart';

class MyOrders extends StatelessWidget {
  MyOrders({super.key});
  static const String routeName = "MyOrders";
  ProductItemModel item = ProductItemModel(
    vendorId: "1",
    description: 'اول منتج يتم بيعه على التطبيق',
    imageBase64: Assets.assetsImagesElectonics,
    productName: 'المنتج الاول',
    price: '13',
    productCategory: 'الكترونيات',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 250, 255),
        appBar: appbarForVendorViews(title: "الطلبات"),
        body: ListView.builder(
          itemCount: 15, // Number of items to build
          itemBuilder: (context, index) {
            return //ProductItemCard(item: item);
                Container();
          },
        ));
  }
}
