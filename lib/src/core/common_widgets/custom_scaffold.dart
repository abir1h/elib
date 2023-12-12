import 'package:flutter/material.dart';

import '../constants/app_theme.dart';
import '../constants/strings.dart';

class CustomScaffold extends StatelessWidget with AppTheme {
  final String title;
  final Color? bgColor;
  final bool resizeToAvoidBottomInset;
  final WillPopCallback? onBack;
  final VoidCallback? onReload;
  final Widget? actionChild;
  final Widget child;
  const CustomScaffold(
      {super.key,
      required this.title,
      this.bgColor,
      this.resizeToAvoidBottomInset = false,
      this.onBack,
      this.onReload,
      this.actionChild,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Title bar
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _onBackPressed().then((value) {
                        if (value) {
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(
                        Icons.arrow_back,
                        color: clr.appPrimaryColorGreen,
                        size: size.r24,
                      ),
                    ),
                  ),
                  SizedBox(width: size.w16),
                  Expanded(
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
                  ),

                  ///Action child
                  if (actionChild != null)
                    GestureDetector(
                      child: actionChild,
                    ),

                  ///Reload button
                  if (onReload != null)
                    GestureDetector(
                      onTap: onReload,
                      child: Container(
                        color: Colors.transparent,
                        child: Icon(
                          Icons.refresh,
                          color: clr.appPrimaryColorGreen,
                          size: size.r28,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Container(color: clr.cardStrokeColor, height: size.h1),

            ///Body section
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: bgColor ?? clr.scaffoldBackgroundColor,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (onBack != null) {
      return onBack!();
    } else {
      return Future.value(true);
    }
  }
}
