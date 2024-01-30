import 'package:flutter/material.dart';

class AppUtility {
  static final AppUtility _instance = AppUtility._();
  AppUtility._();
  static AppUtility? get getInstance => _instance;

  Color? getStatusColor(int? status) {
    Color? color;
    if (status == 0) {
      color = const Color(0xFFFF5256);
    } else if (status == 4) {
      color = const Color(0xFF2FA1F7);
    } else if (status == 2) {
      color = const Color(0xFF1EBDB1);
    } else if (status == 1) {
      color = const Color(0xFF00B962);
    } else if (status == 3) {
      color = const Color(0xFFF8C549);
    }
    return color;
  }
  String getStatusText(int? status) {
    String text = "";
    if (status == 0) {
      text = "Inactive";
    } else if (status == 4) {
      text = "Closed";
    } else if (status == 2) {
      text = "Review";
    } else if (status == 1) {
      text = "Active";
    } else if (status == 3) {
      text = "Hold";
    }
    return text;
  }

  static String parseHtmlToText(String text) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String parsedString = text.trim().replaceAll(exp, ' ');
    return parsedString.trim();
  }

}
