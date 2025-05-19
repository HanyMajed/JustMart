import 'package:flutter/material.dart';
import 'package:just_mart/features/auth/signin_view.dart';
import 'package:just_mart/features/auth/presentation/views/signup_view.dart';
import 'package:just_mart/features/best_selling_product/presentation/views/best_selling_view.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/add_new_card.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/favourite_screen.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/my_payment_cards.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/my_profile_info_page.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/profile_screen.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/who_are_we_page.dart';
import 'package:just_mart/features/splash/presentation/views/on_boarding/presentation/views/on_boarding.dart';
import 'package:just_mart/features/splash/presentation/views/splash_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/add_product_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_orders_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/my_products_view.dart';
import 'package:just_mart/features/vendor_mode/widgets/vendor_purchases_view.dart';
import 'package:just_mart/widgets/forget_password_page.dart';
import 'package:just_mart/widgets/terms_and_conditions_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AddNewCard.routeName:
      return MaterialPageRoute(builder: (context) => const AddNewCard());
    case MyPaymentCards.routeName:
      return MaterialPageRoute(builder: (context) => const MyPaymentCards());
    case MyProfileInfoPage.routeName:
      return MaterialPageRoute(builder: (context) => const MyProfileInfoPage());
    case FavouriteScreen.routeName:
      return MaterialPageRoute(builder: (context) => const FavouriteScreen());
    case WhoAreWePage.routeName:
      return MaterialPageRoute(builder: (context) => const WhoAreWePage());
    case ProfileScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileScreen());
    case ForgetPasswordPage.routeName:
      return MaterialPageRoute(
          builder: (context) => const ForgetPasswordPage());
    case TermsAndConditionsPage.routeName:
      return MaterialPageRoute(
          builder: (context) => const TermsAndConditionsPage());
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case MyOrders.routeName:
      return MaterialPageRoute(builder: (context) => MyOrders());
    case MyProducts.routeName:
      return MaterialPageRoute(builder: (context) => const MyProducts());
    case AddProductView.routeName:
      return MaterialPageRoute(builder: (context) => const AddProductView());
    case VendorPurchases.routeName:
      return MaterialPageRoute(builder: (context) => const VendorPurchases());
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
