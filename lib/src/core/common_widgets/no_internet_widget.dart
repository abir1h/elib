import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/common_imports.dart';
import '../utility/app_label.dart';
import 'custom_switch_button.dart';

class NoInternetWidget extends StatelessWidget with AppTheme {
  final IconData icon;
  final String? title;

  const NoInternetWidget(
      {super.key, this.icon = Icons.signal_wifi_bad, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 80.r, color: clr.iconColorRed),
                    SizedBox(height: size.h40),
                    Text(
                      title ?? "",
                      style: TextStyle(
                          color: clr.appPrimaryColorBlack,
                          fontSize: size.textXMedium,
                          fontWeight: FontWeight.w600,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                    SizedBox(height: size.h12),
                    Text(
                      "",
                      style: TextStyle(
                          color: clr.appPrimaryColorBlack,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                    SizedBox(height: size.h32),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: size.r20,
                          color: clr.appPrimaryColorBlack,
                        ),
                        SizedBox(width: size.w8),
                        Text(
                          "",
                          style: TextStyle(
                              color: clr.appPrimaryColorBlack,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyPoppins),
                        ),
                      ],
                    ),
                    SizedBox(height: 127.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.w20, vertical: size.h8),
                      decoration: BoxDecoration(
                          color: clr.appPrimaryColorBlack,
                          borderRadius:
                              BorderRadius.circular(size.w1 + size.w4)),
                      child: Text(
                        "",
                        style: TextStyle(
                            color: clr.whiteColor,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.h16 - size.h1,
              right: size.w16,
              child: CustomSwitchButton(
                value: App.currentAppLanguage == AppLanguage.english,
                textOn: 'EN',
                textSize: size.textXXSmall,
                textOff: 'বাং',
                bgColor: clr.whiteColor,
                width: 64.w,
                animationDuration: const Duration(milliseconds: 300),
                onChanged: (bool state) {
                  // App.setAppLanguage(state ? 1 : 0).then((value) {
                  //   if (mounted) {
                  //     setState(() {});
                  //   }
                  // });
                },
                buttonHolder: const Icon(
                  Icons.check,
                  color: Colors.transparent,
                ),
                onTap: () {},
                onDoubleTap: () {},
                onSwipe: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
