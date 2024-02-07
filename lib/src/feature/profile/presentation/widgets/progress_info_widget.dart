import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/language.dart';

class ProgressInfoWidget extends StatelessWidget with AppTheme, Language {
  const ProgressInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.h24),
          Container(
            height: 100,
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   // begin: Alignment(.1, 0),
              //   // end: Alignment(1, -1),
              //   // // transform: GradientRotation(math.pi / 4),
              //   colors: [
              //     clr.whiteColor,
              //     Colors.red,
              //   ],
              // ),
              borderRadius: BorderRadius.circular(size.r16),
              border: Border.all(color: clr.cardStrokeColorGrey),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipPath(
                  clipper: BGClipper2(),
                  child: Container(
                    height: MediaQuery.of(context).size.width * .64,
                    width: double.maxFinite,
                    color: clr.appSecondaryColorPurple,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BGClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.width * 0.43);
    path.quadraticBezierTo(
        size.width * .5, size.height * 1.2, size.width, size.height * .4);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(BGClipper1 oldClipper) {
    return true;
  }
}

class BGClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width*.5, size.width * 0.4);
    path.quadraticBezierTo(
        size.width * .5, size.height * 1.1, size.width, size.height * .02);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(BGClipper2 oldClipper) {
    return true;
  }
}
