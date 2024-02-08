import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class NotificationCard extends StatelessWidget with AppTheme {
  final Widget leading;
  final String title;
  final String time;
  final bool seen;
  const NotificationCard(
      {super.key,
      required this.leading,
      required this.title,
      required this.time,
      this.seen = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: seen ? clr.shadeWhiteColor2 : clr.backgroundColorMintCream,
      padding: EdgeInsets.symmetric(horizontal: size.h16, vertical: size.h12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leading,
          SizedBox(width: size.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: clr.textColorBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
                SizedBox(height: size.h8),
                Text(
                  time,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: clr.textColorBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
