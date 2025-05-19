import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_mart/features/home/presentation/views/widgets/custom_bottom_navigatonbar.dart';
import 'package:just_mart/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.signedUID});
  static const String routeName = 'home_view';
  final String signedUID;
  @override
  Widget build(BuildContext context) {
    log(signedUID);
    return Scaffold(
      body: SafeArea(
          child: HomeViewBody(
        signedUID: signedUID,
      )),
    );
  }
}
