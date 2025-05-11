import 'package:flutter/material.dart';

import 'package:just_mart/features/best_selling_product/presentation/views/widgets/best_selling_view_body.dart';
import 'package:just_mart/features/home/presentation/views/widgets/build_app_bar.dart';

class BestSellingView extends StatelessWidget {
  const BestSellingView({super.key});
  static const routeName = 'best_selling_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: ' الأكثر مبيعا'),
      body: const BestSellingViewBody(),
    );
  }
}

  // AppBar buildAppBar() {
  // return AppBar(
  //   actions: const [
  //   Padding(
  //    padding: EdgeInsets.symmetric(horizontal: 16),
  //    child: NotificationWedget(),
  //  )
  //  ],
  // backgroundColor: Colors.transparent,
  //  elevation: 0,
  //  title: const Text(
  //    ' الأكثر مبيعا',
  //    textAlign: TextAlign.center,
  //    style: TextStyles.bold19,

  //  ) ,
  // );
  // }
//}

