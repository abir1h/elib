import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/common_widgets/custom_card_tile.dart';

class ModuleCardWidget extends StatelessWidget with AppTheme {
  final String image;
  final String text;
  final VoidCallback? onTap;
  const ModuleCardWidget(
      {super.key, required this.image, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCardTile(
        horizontal: size.w8,
        vertical: size.h8,
        bgColor: clr.secondaryBackgroundColor,
        borderColor: clr.cardStrokeColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 100.h),
            SizedBox(height: size.h8),
            Text(
              text,
              style: TextStyle(
                  color: clr.textColorAppleBlack,
                  fontSize: size.textXXSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
