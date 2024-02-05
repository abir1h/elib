import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

class AppUtility {
  static final AppUtility _instance = AppUtility._();
  AppUtility._();
  static AppUtility? get getInstance => _instance;

  Color? getStatusColor(int? status) {
    Color? color;
    if (status == 0) {
      color = ThemeColor.instance.statusColorGray;
    } else if (status == 1) {
      color = ThemeColor.instance.statusColorMediumGreen;
    } else if (status == 2) {
      color = ThemeColor.instance.statusColorColoradoPeach;
    } else if (status == 3) {
      color = ThemeColor.instance.statusColorRoyalBlue;
    } else if (status == 4) {
      color = ThemeColor.instance.statusColorRed;
    }
    return color;
  }

  String getStatusText(int? status) {
    String text = "";
    if (status == 0) {
      text = "Inactive";
    } else if (status == 1) {
      text = "Active";
    } else if (status == 2) {
      text = "Review";
    } else if (status == 3) {
      text = "Hold";
    } else if (status == 4) {
      text = "Closed";
    }
    return text;
  }

  static String parseHtmlToText(String text) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String parsedString = text.trim().replaceAll(exp, ' ');
    return parsedString.trim();
  }
}
