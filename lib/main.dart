import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_mart/core/helper_functions/on_generate_routes.dart';
import 'package:just_mart/core/helper_functions/theam_provider.dart';
import 'package:just_mart/core/services/custom_bloc_observer.dart';
import 'package:just_mart/core/services/get_it_service.dart';
import 'package:just_mart/core/services/shared_prefrences_singleton.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/features/cart/cart_provider.dart';
import 'package:just_mart/features/splash/presentation/views/splash_view.dart';
import 'package:just_mart/firebase_options.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  setupGetIt();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const JustMart(),
    ),
  );
}

class JustMart extends StatelessWidget {
  const JustMart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Cairo',
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
            ),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[900],
            fontFamily: 'Cairo',
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primaryColor,
            ),
          ),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: const Locale('ar'),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: onGenerateRoute,
          initialRoute: SplashView.routeName,

          // Add the routeObserver here
          navigatorObservers: [routeObserver],
        );
      },
    );
  }
}
