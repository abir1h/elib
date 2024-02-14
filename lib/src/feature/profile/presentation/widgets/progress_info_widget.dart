import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../progress/domain/entities/progress_data_entity.dart';
import '../service/progress_info_service.dart';

class ProgressInfoWidget extends StatefulWidget {
  const ProgressInfoWidget({super.key});

  @override
  State<ProgressInfoWidget> createState() => _ProgressInfoWidgetState();
}

class _ProgressInfoWidgetState extends State<ProgressInfoWidget>
    with AppTheme, Language, ProgressInfoService {
  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<ProgressDataEntity>(
      stream: progressDataStreamController.stream,
      loadingBuilder: (context) {
        return const Center(child: CircularLoader());
      },
      dataBuilder: (context, data) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.h24),
              /*Container(
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
          ),*/

              ProgressCardWidget(
                title: "অগ্রগতির রিপোর্ট",
                subTitle: "সর্বাধিক পঠিত বই এবং জনপ্রিয় বই গুলো দেখুন",
                subTitleTextSize: size.textXXSmall,
                onTap: onTapBookReport,
              ),
              SizedBox(height: size.h28),
              ProgressCardWidget(
                title: "অনুরোধকৃত বইয়ের তালিকা",
                subTitle: data.bookRequests.toString(),
                onTap: onTapRequestedBook,
              ),
              SizedBox(height: size.h28),
              ProgressCardWidget(
                title: "পঠিত বইয়ের তালিকা",
                subTitle: data.bookViews.toString(),
                onTap: onTapReadBook,
              ),
              SizedBox(height: size.h64),
            ],
          ),
        );
      },
      emptyBuilder: (context, message, icon) => EmptyWidget(
        message: message,
        offset: 350.w,
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void navigateToBookReportScreen() {
    Navigator.of(context).pushNamed(AppRoute.bookViewDownloadCountScreen);
  }

  @override
  void navigateToRequestedBookScreen() {
    Navigator.of(context).pushNamed(AppRoute.bookRequestListScreen);
  }

  @override
  void navigateToReadBookScreen() {
    Navigator.of(context).pushNamed(AppRoute.readBooksScreen);
  }
}

class ProgressCardWidget extends StatelessWidget with AppTheme {
  final String title;
  final String subTitle;
  final double? subTitleTextSize;
  final VoidCallback onTap;
  const ProgressCardWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.subTitleTextSize,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h28),
        decoration: BoxDecoration(
          color: clr.whiteColor,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: clr.appPrimaryColorBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: size.h2),
            Text(
              subTitle,
              style: TextStyle(
                  color: clr.textColorGray,
                  fontSize: subTitleTextSize ?? size.textSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
    path.lineTo(size.width * .5, size.width * 0.4);
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

class MyPolygon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * .8, 0);
    path.lineTo(size.width * .7, size.height * .2);
    path.lineTo(size.width * .85, size.height * .6);
    path.lineTo(size.width, size.height * .4);
    path.lineTo(size.width, 0);
    path.close();

    ///
    // path.lineTo(size.width * 0.8, 0);
    // path.quadraticBezierTo(
    //     size.width *.7, size.height * .5, size.width, size.height * .4);
    // path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
