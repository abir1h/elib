import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feature/landing/presentation/bindings/landing_binding.dart';
import '../../feature/landing/presentation/screens/landing_screen.dart';
import '../../feature/root/presentation/binding/root_binding.dart';
import '../../feature/root/presentation/screens/root_screen.dart';
import '../../feature/splash/bindings/splash_binding.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splash = '/splash';
  static const String landing = '/landing';
  static const String bottomNav = '/bottomNav';

}

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.landing,
      page: () => const LandingScreen(),
      binding: LandingBinding(),
      transition: Transition.rightToLeft,
    ),


    GetPage(
      name: AppRoutes.bottomNav,
      page: () => const RootScreen(),
      binding: RootBinding(),
      transition: Transition.rightToLeft,
    ),

  ];
}


class RouterGenerator {
  RouterGenerator._();

  static Route<String>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<String> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}
