import 'package:flutter/material.dart';
import 'package:just_mart/widgets/custom_appbar.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  static const routeName = 'favourite-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'قائمة المفضله'),
    );
  }
}
