import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/strings.dart';
import '../core/routes/app_routes.dart';
import '../core/constants/app_theme.dart';
import 'splash/presentation/screens/splash_screen.dart';

class Application extends StatelessWidget with AppTheme {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'eLibrary',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(primary: clr.appPrimaryColorGreen),
                scaffoldBackgroundColor: clr.scaffoldBackgroundColor,
                dividerColor: Colors.transparent,
                fontFamily: StringData.fontFamilyPoppins,
                canvasColor: Colors.transparent),
            initialRoute: AppRoutes.splash,
            onGenerateRoute: RouterGenerator.generateRoute,
            home: const SplashScreen(),
          );
        });
  }
}
