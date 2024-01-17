import 'package:flutter/material.dart';
import '../../feature/clms_landing/presentation/screens/landing_screen.dart';
import '../../feature/root/presentation/screens/root_screen.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';

class AppRoute {
  AppRoute._();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splashScreen = '/splash';
  static const String authenticate = '/authenticate';
  static const String landing = '/landing';
  static const String bottomNav = '/bottomNav';
}

mixin RouteGenerator {
  static Route<dynamic> generate(RouteSettings setting) {
    return FadeInOutRouteBuilder(
        builder: (context) {
      switch (setting.name) {
      ///StartUp
        case AppRoute.splashScreen:return const SplashScreen();
      ///Default Screen
        default:return const SplashScreen();

      }});}}





///This defines the animation of routing one page to another
class FadeInOutRouteBuilder extends PageRouteBuilder {
  final WidgetBuilder builder;
  FadeInOutRouteBuilder({required this.builder}) : super(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.50,
            1.00,
            curve: Curves.linear,
          ),
        ),
      ),
      child: child,
    );
  });
}
