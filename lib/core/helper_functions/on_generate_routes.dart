import 'package:flutter/material.dart';
import 'package:just_mart/features/auth/signin_view.dart';
import 'package:just_mart/features/auth/presentation/views/signup_view.dart';
import 'package:just_mart/features/best_selling_product/presentation/views/best_selling_view.dart';
import 'package:just_mart/features/home/presentation/views/home_view.dart';
import 'package:just_mart/features/splash/presentation/views/on_boarding/presentation/views/on_boarding.dart';
import 'package:just_mart/features/splash/presentation/views/splash_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/add_product.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_orders.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_products.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case MyOrders.routeName:
      return MaterialPageRoute(builder: (context) => const MyOrders());
    case MyProducts.routeName:
      return MaterialPageRoute(builder: (context) => const MyProducts());
    case AddProduct.routeName:
      return MaterialPageRoute(builder: (context) => const AddProduct());
    case BestSellingView.routeName:
      return MaterialPageRoute(builder: (context) => const BestSellingView());
    case SignInView.routeName:
      return MaterialPageRoute(builder: (context) => const SignInView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());
    // case HomeView.routeName:
    // return MaterialPageRoute(builder: (context) => const HomeView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
