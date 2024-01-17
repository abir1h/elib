import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with AppTheme, Language {
  final AuthenticationController authenticationController = Get.put(AuthenticationController());


  final _formKey = GlobalKey<FormState>();


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
                              color: clr.appPrimaryColorGreen,
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
                            color: clr.appPrimaryColorGreen,
                            fontSize: size.textSmall,
                            fontFamily: StringData.fontFamilyInter,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: size.h20),
                        CustomButton(
                            onTap: () => Get.toNamed(AppRoutes.landing),
                            title: label(e: en.loginText, b: bn.loginText))
                        // Form(
                        //     key: _formKey,
                        //     child: Column(
                        //       children: [
                        //         AppTextField(
                        //           hintText: StringData.userNameHintText,
                        //           focusNode:
                        //               authenticationController.userIdFocusNode,
                        //           controller: authenticationController
                        //               .userIdEditingController,
                        //           validator: (value) {
                        //             if (value == null || value.isEmpty) {
                        //               return 'Enter your PDSID';
                        //             } else {
                        //               return null;
                        //             }
                        //           },
                        //         ),
                        //         SizedBox(height: size.h12),
                        //         Obx(() => AppTextField(
                        //               hintText: StringData.passwordHintText,
                        //               focusNode: authenticationController
                        //                   .passFocusNode,
                        //               controller: authenticationController
                        //                   .passwordEditingController,
                        //               obscureText: authenticationController
                        //                       .watchPassword.value
                        //                   ? true
                        //                   : false,
                        //               validator: (value) {
                        //                 if (value == null || value.isEmpty) {
                        //                   return 'Enter your password';
                        //                 }
                        //                 return null;
                        //               },
                        //               suffixIcon: GestureDetector(
                        //                   onTap: () {
                        //                     authenticationController
                        //                         .toggleWatchPassword(
                        //                             !authenticationController
                        //                                 .watchPassword.value);
                        //                   },
                        //                   child: Icon(
                        //                     authenticationController
                        //                             .watchPassword.value
                        //                         ? Icons.visibility_off
                        //                         : Icons.visibility,
                        //                     color: clr.iconColorHint,
                        //                     size: 20.r,
                        //                   )),
                        //             )),
                        //         SizedBox(height: size.h24),
                        //         /*  CustomActionButton(
                        //             title: StringData.loginText,
                        //             controller: authenticationController
                        //                 .buttonController,
                        //             onCheck: () => authenticationController
                        //                 .validateLoginForeignFormData(
                        //                     authenticationController
                        //                         .userIdEditingController,
                        //                     authenticationController
                        //                         .passwordEditingController),
                        //             onSuccess: (e) {},
                        //             tapAction: _sendAuthRequest),*/
                        //       ],
                        //     )),
                      ],
                    ),
                    Column(
                      children: [
                        Text.rich(TextSpan(
                            text: label(
                                e: en.copyRightText2, b: bn.copyRightText2),
                            style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textXXSmall,
                              fontWeight: FontWeight.w400,
                              fontFamily: StringData.fontFamilyInter,
                            ),
                            children: [
                              TextSpan(
                                text: ' | ',
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                              TextSpan(
                                text: label(
                                    e: en.copyRightText4, b: bn.copyRightText4),
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                              TextSpan(
                                text: ' | ',
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                              TextSpan(
                                text: label(
                                    e: en.copyRightText5, b: bn.copyRightText5),
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                            ])),
                        Text.rich(TextSpan(
                            text:
                                label(e: en.copyRightText, b: bn.copyRightText),
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
                                    e: en.copyRightText3, b: bn.copyRightText3),
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
