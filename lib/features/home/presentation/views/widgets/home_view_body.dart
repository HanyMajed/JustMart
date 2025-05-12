import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:just_mart/constants.dart';
import 'package:just_mart/features/home/presentation/views/widgets/best_selling_gridView.dart';
import 'package:just_mart/features/home/presentation/views/widgets/best_selling_header.dart';
import 'package:just_mart/features/home/presentation/views/widgets/custom_home_appbar.dart';
import 'package:just_mart/features/home/presentation/views/widgets/featured_list.dart';
import 'package:just_mart/features/home/presentation/views/widgets/search_text_field.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.signedUID});
  final String signedUID;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizantalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: kTopPadding,
                ),
                CustomHomeAppbar(
                  signedUID: signedUID,
                ),
                const SizedBox(
                  height: kTopPadding,
                ),
                const SearchTextfield(),
                const SizedBox(
                  height: 12,
                ),
                const FeaturedList(),
                const SizedBox(
                  height: 12,
                ),
                const BestSellingHeader(),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          const BestSellingGridview(),
        ],
      ),
    );
  }
}
