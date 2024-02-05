import 'package:flutter/material.dart';

import '../constants/common_imports.dart';

class HeaderWidget extends StatelessWidget with AppTheme {
  final String title;
  const HeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: size.h1, color: clr.cardStrokeColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              padding: EdgeInsets.all(size.r6),
              decoration: BoxDecoration(
                color: clr.whiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: clr.appPrimaryColorBlack.withOpacity(.2),
                    blurRadius: size.r8,
                    offset: Offset(0.0, size.h2),
                  ),
                ],
              ),
              child: Icon(
                Icons.menu,
                size: size.r24,
                color: clr.appPrimaryColorBlack,
              ),
            ),
          ),
          SizedBox(width: size.w12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: clr.appPrimaryColorBlack,
                  fontSize: size.textXMedium,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
