import 'package:flutter/material.dart';

import '../constants/common_imports.dart';

class HeaderWidget extends StatelessWidget with AppTheme {
  final String title;
  final VoidCallback onTapNotification;
  const HeaderWidget(
      {super.key, required this.title, required this.onTapNotification});

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
                    color: clr.appSecondaryColorPurple.withOpacity(.2),
                    blurRadius: size.r8,
                    offset: Offset(0.0, size.h2),
                  ),
                ],
              ),
              child: Icon(
                Icons.menu,
                size: size.r24,
                color: clr.appSecondaryColorPurple,
              ),
            ),
          ),
          SizedBox(width: size.w12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: clr.appSecondaryColorPurple,
                  fontSize: size.textXMedium,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: onTapNotification,
            child: Stack(
              children: [
                Icon(
                  Icons.notifications,
                  color: clr.appSecondaryColorPurple,
                  size: size.r24,
                ),
                Positioned(
                  right: -1,
                  top: size.h2,
                  child: Container(
                    width: size.w12,
                    height: size.h12,
                    decoration: BoxDecoration(
                        color: clr.appSecondaryColorPurple,
                        shape: BoxShape.circle,
                        border: Border.all(color: clr.whiteColor)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
