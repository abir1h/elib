import 'package:elibrary/src/core/constants/app_theme.dart';
import 'package:elibrary/src/core/constants/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
class BookInfoItemWidget extends StatelessWidget with AppTheme,Language {
  const BookInfoItemWidget({super.key, required this.firstItem, required this.secondItem});
  final String firstItem,secondItem;

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.only(
          left: 26.w, right: 26.w,bottom: size.h8),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 35,
            child: Text(
              firstItem,
              style: TextStyle(
                color: clr.appPrimaryColorBlack,
                fontWeight: FontWeight.w600,
                fontSize: size.textSmall,
                fontFamily:
                StringData.fontFamilyPoppins,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.w8),
            child: Text(
              ":",
              style: TextStyle(
                color: clr.appPrimaryColorBlack,
                fontWeight: FontWeight.w500,
                fontSize: size.textSmall,
                fontFamily:
                StringData.fontFamilyPoppins,
              ),
            ),
          ),
          Expanded(
            flex: 60,
            child: Text(
             secondItem,
              style: TextStyle(
                color: clr.appPrimaryColorBlack,
                fontWeight: FontWeight.w500,
                fontSize: size.textSmall,
                fontFamily:
                StringData.fontFamilyPoppins,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
