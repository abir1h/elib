import 'package:elibrary/src/feature/report/presentation/screens/book_report_list_screen.dart';
import 'package:elibrary/src/feature/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import '../../feature/authentication/presentation/screens/authentication_screen.dart';
import '../../feature/authentication/presentation/screens/emis_webview_screen.dart';
import '../../feature/author/presentation/screens/author_books_screen.dart';
import '../../feature/author/presentation/screens/author_screen.dart';
import '../../feature/book/presentation/screens/book_details_screen.dart';
import '../../feature/book/presentation/screens/book_request_list_screen.dart';
import '../../feature/book/presentation/screens/book_view_screen.dart';
import '../../feature/book/presentation/screens/tag_book_screen.dart';
import '../../feature/category/presentation/screens/category_details_screen.dart';
import '../../feature/clms_landing/presentation/screens/landing_screen.dart';
import '../../feature/base/presentation/screens/base_screen.dart';
import '../../feature/home/presentation/screens/latest_books_screen.dart';
import '../../feature/note/presentation/screens/note_details_screen.dart';
import '../../feature/note/presentation/screens/note_screen.dart';
import '../../feature/note/presentation/screens/note_edit_screen.dart';
import '../../feature/notification/presentation/screens/notification_screen.dart';
import '../../feature/progress/presentation/screens/read_books_screen.dart';
import '../../feature/report/presentation/screens/book_view_report_screen.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';

class AppRoute {
  AppRoute._();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splashScreen = 'splashScreen';
  static const String authenticationScreen = 'authenticationScreen';
  static const String eMISWebViewScreen = "eMISWebViewScreen";

  static const String landingScreen = 'landingScreen';
  static const String baseScreen = 'baseScreen';
  static const String bookDetailsScreen = 'bookDetailsScreen';
  static const String categoryDetailsScreen = 'categoryDetailsScreen';
  static const String bookViewScreen = 'bookViewScreen';
  static const String bookViewDownloadCountScreen =
      'bookViewDownloadCountScreen';
  static const String bookViewDownloadCountListScreen =
      'bookViewDownloadCountListScreen';
  static const String noteScreen = 'noteScreen';
  static const String noteDetailsScreen = 'noteDetailsScreen';
  static const String noteDetailsScreenBeta = 'noteDetailsScreenBeta';
  static const String bookRequestListScreen = 'bookRequestListScreen';
  static const String authorScreen = 'authorScreen';
  static const String authorBooksScreen = 'authorBooksScreen';
  static const String notificationScreen = 'notificationScreen';
  static const String tagBookScreen = 'tagBookScreen';
  static const String readBooksScreen = 'readBooksScreen';
  static const String latestBookScreen = 'latestBookScreen';
  static const String searchScreen = 'searchScreen';
}

mixin RouteGenerator {
  static Route<dynamic> generate(RouteSettings setting) {
    return FadeInOutRouteBuilder(builder: (context) {
      switch (setting.name) {
        ///StartUp
        case AppRoute.splashScreen:
          return const SplashScreen();
        case AppRoute.authenticationScreen:
          return const AuthenticationScreen();
        case AppRoute.eMISWebViewScreen:
          return EMISWebViewScreen(arguments: setting.arguments);

        ///CLMS Landing Screen
        case AppRoute.landingScreen:
          return const LandingScreen();

        /// Base Screen - Bottom NavBar Screen
        case AppRoute.baseScreen:
          return const BaseScreen();

        /// Book Details Screen
        case AppRoute.bookDetailsScreen:
          return BookDetailsScreen(arguments: setting.arguments);

        /// Category Details Screen
        case AppRoute.categoryDetailsScreen:
          return CategoryDetailsScreen(arguments: setting.arguments);

        /// Book View Details Screen
        case AppRoute.bookViewScreen:
          return BookViewerScreen(arguments: setting.arguments);

        /// Book Report Details Screen
        case AppRoute.bookViewDownloadCountScreen:
          return const BookVIewDownloadScreen();

        /// Book Report List Details Screen
        case AppRoute.bookViewDownloadCountListScreen:
          return BookReportListScreen(arguments: setting.arguments);

        ///Notes
        case AppRoute.noteScreen:
          return const NoteScreen();
        case AppRoute.noteDetailsScreen:
          return NoteDetailsScreen(arguments: setting.arguments);
        case AppRoute.noteDetailsScreenBeta:
          return NoteEditScreen(arguments: setting.arguments);

        ///Book Request
        case AppRoute.bookRequestListScreen:
          return const BookRequestListScreen();

        ///Author
        case AppRoute.authorScreen:
          return const AuthorScreen();
        case AppRoute.authorBooksScreen:
          return AuthorBooksScreen(arguments: setting.arguments);

        ///Books By Tag
        case AppRoute.tagBookScreen:
          return TagBookScreen(arguments: setting.arguments);

        case AppRoute.readBooksScreen:
          return const ReadBooksScreen();

        case AppRoute.latestBookScreen:
          return LatestBookScreen(arguments: setting.arguments);
        case AppRoute.searchScreen:
          return const BookSearchScreen();

        ///Notification
        case AppRoute.notificationScreen:
          return const NotificationScreen();

        ///Default Screen
        default:
          return const SplashScreen();
      }
    });
  }
}

///This defines the animation of routing one page to another
class FadeInOutRouteBuilder extends PageRouteBuilder {
  final WidgetBuilder builder;
  FadeInOutRouteBuilder({required this.builder})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
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
