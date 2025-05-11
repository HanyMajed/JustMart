import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:just_mart/constants.dart';
import 'package:just_mart/features/home/presentation/views/widgets/best_selling_gridView.dart';
import 'package:just_mart/features/home/presentation/views/widgets/best_selling_header.dart';
import 'package:just_mart/features/home/presentation/views/widgets/custom_home_appbar.dart';
import 'package:just_mart/features/home/presentation/views/widgets/featured_list.dart';
import 'package:just_mart/features/home/presentation/views/widgets/search_text_field.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kHorizantalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: kTopPadding,
                ),
                CustomHomeAppbar(),
                SizedBox(
                  height: kTopPadding,
                ),
                SearchTextfield(),
                SizedBox(
                  height: 12,
                ),
                FeaturedList(),
                SizedBox(
                  height: 12,
                ),
                BestSellingHeader(),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          BestSellingGridview(),
        ],
      ),
    );
  }
}
