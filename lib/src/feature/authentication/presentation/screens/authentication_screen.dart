import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../services/auth_service.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: size.w28),
          child: Stack(
            children: [
              SizedBox(
                height: 1.sh,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.h32),
                          Center(
                            child: Image.asset(
                              ImageAssets.icLogo,
                              height: size.h32 + size.h4,
                            ),
                          ),
                          SizedBox(height: size.h2 + size.h24),
                          Text(
                            label(
                                e: en.authScreenHeaderText,
                                b: bn.authScreenHeaderText),
                            style: TextStyle(
                                color: clr.appPrimaryColorBlack,
                                fontSize: size.textXMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                          ),
                          SizedBox(height: size.h12),
                          Text(
                            label(
                                e: en.authScreenContentText,
                                b: bn.authScreenContentText),
                            style: TextStyle(
                              color: clr.textColorAppleBlack,
                              fontSize: size.textXSmall,
                              fontFamily: StringData.fontFamilyInter,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: size.h10),
                          Text(
                            label(
                                e: en.authScreenContentText2,
                                b: bn.authScreenContentText2),
                            style: TextStyle(
                              color: clr.textColorAppleBlack,
                              fontSize: size.textXSmall,
                              fontFamily: StringData.fontFamilyInter,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: size.h10),
                          Text(
                            label(
                                e: en.authScreenContentText3,
                                b: bn.authScreenContentText3),
                            style: TextStyle(
                              color: clr.textColorAppleBlack,
                              fontSize: size.textXSmall,
                              fontFamily: StringData.fontFamilyInter,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: size.h24),
                          Text(
                            label(
                                e: en.authScreenLoginText,
                                b: bn.authScreenLoginText),
                            style: TextStyle(
                              color: clr.appPrimaryColorBlack,
                              fontSize: size.textSmall,
                              fontFamily: StringData.fontFamilyInter,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: size.h20),
                          CustomButton(
                              onTap: () {
                                AuthService.getEMISLink()
                                    .then((responseEntity) {
                                  Navigator.of(context).pushNamed(
                                      AppRoute.eMISWebViewScreen,
                                      arguments: EMISWebViewScreenArgs(
                                          webViewLink:
                                              responseEntity.data.url));
                                  // Get.to(() => EMISWebViewScreen(
                                  //     webViewLink: responseEntity.data.url));
                                });
                                // ApiService()
                                //     .getRequest(ApiCredential.userLogin)
                                //     .then((value) {
                                //   EMISLoginResponse loginResponse =
                                //       EMISLoginResponse.fromJson(
                                //           json.decode(value));
                                //   Get.to(() => EMISWebViewScreen(
                                //       webViewLink: loginResponse.data.url));
                                // });
                                // Get.toNamed(AppRoutes.landing);
                              },
                              title: label(e: en.loginText, b: bn.loginText)),
                          SizedBox(height: size.h12),
                        ],
                      ),
                      Column(
                        children: [
                          Text.rich(TextSpan(
                              text: label(
                                  e: en.copyRightText2, b: bn.copyRightText2),
                              style: TextStyle(
                                color: clr.appPrimaryColorBlack,
                                fontSize: size.textXXSmall,
                                fontWeight: FontWeight.w400,
                                fontFamily: StringData.fontFamilyInter,
                              ),
                              children: [
                                TextSpan(
                                  text: ' | ',
                                  style: TextStyle(
                                    color: clr.appPrimaryColorBlack,
                                    fontSize: size.textXXSmall,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: StringData.fontFamilyInter,
                                  ),
                                ),
                                TextSpan(
                                  text: label(
                                      e: en.copyRightText4,
                                      b: bn.copyRightText4),
                                  style: TextStyle(
                                    color: clr.appPrimaryColorBlack,
                                    fontSize: size.textXXSmall,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: StringData.fontFamilyInter,
                                  ),
                                ),
                                TextSpan(
                                  text: ' | ',
                                  style: TextStyle(
                                    color: clr.appPrimaryColorBlack,
                                    fontSize: size.textXXSmall,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: StringData.fontFamilyInter,
                                  ),
                                ),
                                TextSpan(
                                  text: label(
                                      e: en.copyRightText5,
                                      b: bn.copyRightText5),
                                  style: TextStyle(
                                    color: clr.appPrimaryColorBlack,
                                    fontSize: size.textXXSmall,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: StringData.fontFamilyInter,
                                  ),
                                ),
                              ])),
                          Text.rich(TextSpan(
                              text: label(
                                  e: en.copyRightText, b: bn.copyRightText),
                              style: TextStyle(
                                color: clr.textColorAppleBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: ThemeSize.instance.textXXSmall,
                                fontFamily: StringData.fontFamilyInter,
                              ),
                              children: [
                                TextSpan(
                                  text: ' | ',
                                  style: TextStyle(
                                    color: clr.textColorAppleBlack,
                                    fontSize: size.textXXSmall,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: StringData.fontFamilyInter,
                                  ),
                                ),
                                TextSpan(
                                  text: label(
                                      e: en.copyRightText3,
                                      b: bn.copyRightText3),
                                  style: TextStyle(
                                    color: clr.textColorAppleBlack,
                                    fontSize: size.textXXSmall,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: StringData.fontFamilyInter,
                                  ),
                                ),
                              ])),
                          SizedBox(height: size.h40)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 16,
                child: CustomSwitchButton(
                  value: App.currentAppLanguage == AppLanguage.english,
                  textOn: 'EN',
                  textSize: size.textXXSmall,
                  textOff: 'বাং',
                  bgColor: clr.whiteColor,
                  width: 64.w,
                  animationDuration: const Duration(milliseconds: 300),
                  onChanged: (bool state) {
                    App.setAppLanguage(state ? 1 : 0).then((value) {
                      if (mounted) {
                        setState(() {});
                      }
                    });
                  },
                  buttonHolder: const Icon(
                    Icons.check,
                    color: Colors.transparent,
                  ),
                  onTap: () {},
                  onDoubleTap: () {},
                  onSwipe: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
