import 'package:elibrary/src/feature/book/presentation/services/book_service.dart';
import 'package:elibrary/src/feature/shared/domain/entities/response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../services/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AppTheme, SplashService, BookService {
  @override
  void initState() {
    super.initState();
    _callMethod();
  }

  _callMethod() async {
    ResponseEntity responseEntity = await getBookmarkBookList();
    // print(responseEntity.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(bottom: 0.5.sh + 30.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageAssets.icLogo,
                height: size.h64,
              ),
              SizedBox(height: size.h32 + size.h6),
              Text(
                "Welcome To CLMS",
                style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textXXSmall + size.textXXSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void navigateToLandingScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.landingScreen, (x) => false);
  }
}
