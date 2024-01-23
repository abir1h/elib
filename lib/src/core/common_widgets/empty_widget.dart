import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/common_imports.dart';

class EmptyWidget extends StatelessWidget with AppTheme {
  final String message;
  final IconData icon;
  const EmptyWidget(
      {Key? key, required this.message, this.icon = Icons.weekend_outlined})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.all(size.r24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(icon, size: size.r28 * 1.3, color: clr.iconColorWhiteIce),
              Lottie.asset(ImageAssets.animEmpty),
              SizedBox(height: size.h8),
              Text(
                message,
                style: TextStyle(
                  fontSize: size.textMedium,
                  color: clr.blackColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.h32),
            ],
          ),
        ),
      ),
    );
  }
}
