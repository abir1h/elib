import 'package:elibrary/src/feature/category/data/data_sources/remote/category_data_source.dart';
import 'package:elibrary/src/feature/category/data/models/category_data_model.dart';
import 'package:elibrary/src/feature/shared/data/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/constants/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AppTheme {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callMethod();
  }

  _callMethod() async{
    if(mounted){
      CategoryRemoteDataSourceImp categoryRemoteDataSourceImp = CategoryRemoteDataSourceImp();
      List<CategoryDataModel> categoryDataModel = await categoryRemoteDataSourceImp.getCategoriesActio();
      print(categoryDataModel.first.id);
    }
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
