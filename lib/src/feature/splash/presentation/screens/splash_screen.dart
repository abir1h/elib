import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/constants/strings.dart';
import '../../../category/presentation/services/category_service.dart';
import '../../../book/presentation/services/book_service.dart';
import '../../../shared/domain/entities/response_entity.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AppTheme, CategoryService, BookService {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callMethod();
  }

  _callMethod() async{
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
}
