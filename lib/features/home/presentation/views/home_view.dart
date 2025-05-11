import 'package:flutter/material.dart';
import 'package:just_mart/features/home/presentation/views/widgets/custom_bottom_navigatonbar.dart';
import 'package:just_mart/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = 'home_view';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavigatonbar(),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
