import 'package:flutter/material.dart';

import '../constants/common_imports.dart';

class HeaderWidget extends StatelessWidget with AppTheme {
  final String title;
  const HeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h8),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: size.h1, color: clr.cardStrokeColor)),
      ),
      child: Text(
        title,
        style: TextStyle(
            color: clr.appPrimaryColorGreen,
            fontSize: size.textXMedium,
            fontWeight: FontWeight.w500,
            fontFamily: StringData.fontFamilyPoppins),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
