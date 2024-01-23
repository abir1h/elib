import '../../../../core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget with AppTheme {
  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      this.child,
      this.icons,
      this.minimumSize,
      this.primaryColor})
      : super(key: key);
  final Function() onPressed;
  final IconData? icons;
  final Widget? child;
  final Size? minimumSize;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: primaryColor,
          minimumSize: minimumSize,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.w28))),
      child: child,
    );
  }
}
