import 'package:flutter/material.dart';

class AppScrollView extends StatelessWidget {
  final Widget child;
  final ScrollPhysics? scrollPhysics;
  final Axis scrollAxis;
  final EdgeInsetsGeometry? padding;
  const AppScrollView(
      {Key? key,
      required this.child,
      this.scrollPhysics,
      this.scrollAxis = Axis.vertical,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        physics: scrollPhysics ?? const BouncingScrollPhysics(),
        scrollDirection: scrollAxis,
        padding: padding,
        child: child,
      ),
    );
  }
}
