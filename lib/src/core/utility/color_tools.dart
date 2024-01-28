import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String? hexColor) {
    hexColor = hexColor != null
        ? hexColor.toUpperCase()
        : 'FFFFFF';
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// Color? getStatusColor(String status){
//   Color? color;
//
//   if(status.toLowerCase() == "not answered") {
//     color= const Color(0xFFFF5256);
//   } else if(status.toLowerCase() == "answered") {
//     color= const Color(0xFF2FA1F7);
//   } else if(status.toLowerCase() == "accepted") {
//     color= const Color(0xFF1EBDB1);
//   } else if(status.toLowerCase() == "corrected") {
//     color= const Color(0xFF00B962);
//   } else if(status.toLowerCase() == "re-answered") {
//     color= const Color(0xFFA13FE3);
//   } else if(status.toLowerCase() == "cancelled") {
//     color= const Color(0xFFF8C549);
//   }
//   return color;
// }