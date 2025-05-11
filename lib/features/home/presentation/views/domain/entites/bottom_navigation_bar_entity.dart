import 'package:just_mart/core/utils/app_images.dart';

class BottomNavigationBarEntity {
  final String activeImage, inAactiveImage;
  final String name;

  BottomNavigationBarEntity({required this.activeImage, required this.inAactiveImage, required this.name});
}

List<BottomNavigationBarEntity> get bottomNavigationBarItems => [
      BottomNavigationBarEntity(
          activeImage: Assets.assetsImagesVuesaxOutlineHome, inAactiveImage: Assets.assetsImagesVuesaxOutlineHome, name: ' الرئيسية'),
      BottomNavigationBarEntity(
          activeImage: Assets.assetsImagesVuesaxBoldProducts, inAactiveImage: Assets.assetsImagesVuesaxOutlineProducts, name: ' المنتجات'),
      BottomNavigationBarEntity(
          activeImage: Assets.assetsImagesVuesaxBoldShoppingCart,
          inAactiveImage: Assets.assetsImagesVuesaxOutlineShoppingCart,
          name: ' سلة التسوق'),
      BottomNavigationBarEntity(
          activeImage: Assets.assetsImagesVuesaxBoldUser, inAactiveImage: Assets.assetsImagesVuesaxOutlineUser, name: ' حسابي')
    ];
