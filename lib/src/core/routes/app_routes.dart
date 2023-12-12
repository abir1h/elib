import 'package:flutter/material.dart';

import '../../feature/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splash = '/splash';
}

// class AppPages {
//   AppPages._();
//
//   static final pages = [
//     GetPage(
//       name: AppRoutes.splash,
//       page: () => const SplashScreen(),
//       binding: SplashBinding(),
//       transition: Transition.rightToLeft,
//     ),
//   ];
// }

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
