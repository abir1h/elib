import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/common_imports.dart';

mixin CustomDialogWidget {
  static Future<bool> show({
    required BuildContext context,
    required String infoText,
    String title = "Are You Sure?",
    String rightButtonText = "Yes",
    String leftButtonText = "Cancel",
    bool singleButton = false,
  }) {
    Completer<bool> completer = Completer();
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {},
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ThemeSize.instance.w24,
                      vertical: ThemeSize.instance.h24),
                  padding: EdgeInsets.symmetric(
                      horizontal: ThemeSize.instance.w20,
                      vertical: ThemeSize.instance.h24),
                  decoration: BoxDecoration(
                    color: ThemeColor.instance.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout,
                          size: 32.r,
                          color: ThemeColor.instance.appSecondaryColorFlagRed),
                      SizedBox(height: ThemeSize.instance.h12),
                      Text(
                        title,
                        style: TextStyle(
                            color: ThemeColor.instance.textColorBlack,
                            fontSize: ThemeSize.instance.textMedium,
                            fontWeight: FontWeight.w600,
                            fontFamily: StringData.fontFamilyPoppins),
                        textAlign:
                            singleButton ? TextAlign.left : TextAlign.center,
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        infoText,
                        style: TextStyle(
                            color: ThemeColor.instance.textColorBlack,
                            fontSize: ThemeSize.instance.textSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: ThemeSize.instance.h32),
                      Row(
                        children: [
                          Expanded(
                            child: singleButton
                                ? const Offstage()
                                : GestureDetector(
                                    onTap: () =>
                                        Navigator.of(context).pop(false),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 10.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        color: ThemeColor
                                            .instance.appSecondaryColorPurple,
                                        border: Border.all(
                                            color: ThemeColor.instance
                                                .appSecondaryColorPurple,
                                            width: 1.w),
                                      ),
                                      child: Center(
                                        child: Text(
                                          leftButtonText,
                                          style: TextStyle(
                                              color: ThemeColor
                                                  .instance.shadeWhiteColor2,
                                              fontSize:
                                                  ThemeSize.instance.textSmall,
                                              fontWeight: FontWeight.w500,
                                              fontFamily:
                                                  StringData.fontFamilyPoppins),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(true),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: ThemeColor.instance.shadeWhiteColor2,
                                  border: Border.all(
                                      color: ThemeColor
                                          .instance.appSecondaryColorPurple,
                                      width: 1.w),
                                ),
                                child: Center(
                                  child: Text(
                                    rightButtonText,
                                    style: TextStyle(
                                        color: ThemeColor
                                            .instance.appSecondaryColorPurple,
                                        fontSize: ThemeSize.instance.textSmall,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((x) {
      if (x != null && x) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    });
    return completer.future;
  }
}
