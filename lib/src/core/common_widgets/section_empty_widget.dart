

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';
import 'package:flutter/material.dart';

class SectionEmptyWidget extends StatelessWidget with AppTheme{
  final BoxConstraints constraints;
  final String message;
  final double? offset;
  final IconData icon;
  const SectionEmptyWidget({Key? key,required this.constraints,required this.message, this.icon = Icons.weekend_outlined, this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: constraints.maxHeight - (offset??242.w),
      child: Padding(
        padding: EdgeInsets.all(size.h24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: size.h64 * 1.3,
                color: clr.appPrimaryColorBlack.withOpacity(.26),
              ),
              SizedBox(height: size.h8,),
              Text(
                message,
                style: TextStyle(
                  color: clr.appPrimaryColorBlack,
                  fontSize: size.textSmall,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}