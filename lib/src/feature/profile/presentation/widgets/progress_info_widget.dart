import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../progress/domain/entities/progress_data_entity.dart';

class ProgressInfoWidget extends StatelessWidget with AppTheme, Language {
  final ProgressDataEntity data;
  final VoidCallback onTapBookReport;
  final VoidCallback onTapRequestedBook;
  final VoidCallback onTapReadBook;
  const ProgressInfoWidget({
    super.key,
    required this.data,
    required this.onTapBookReport,
    required this.onTapRequestedBook,
    required this.onTapReadBook,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.h24),
          ProgressCardWidget(
            title: "অগ্রগতির রিপোর্ট",
            subTitle: "সর্বাধিক পঠিত বই এবং জনপ্রিয় বই গুলো দেখুন",
            subTitleTextSize: size.textXXSmall,
            iconImage: ImageAssets.medal,
            onTap: onTapBookReport,
            colors: [
              clr.lightPrimaryColorPurple,
              clr.whiteColor,
            ],
          ),
          SizedBox(height: size.h28),
          ProgressCardWidget(
            title: "অনুরোধকৃত বইয়ের তালিকা",
            subTitle: data.bookRequests.toString(),
            onTap: onTapRequestedBook,
            iconImage: ImageAssets.tag,
            colors: [
              clr.gradientGreen,
              clr.whiteColor,
            ],
          ),
          SizedBox(height: size.h28),
          ProgressCardWidget(
            title: "পঠিত বইয়ের তালিকা",
            subTitle: data.bookViews.toString(),
            onTap: onTapReadBook,
            iconImage: ImageAssets.book,
            colors: [
              clr.gradientOrange,
              clr.whiteColor,
            ],
          ),
          SizedBox(height: size.h64 * 2),
        ],
      ),
    );
  }
}

class ProgressCardWidget extends StatelessWidget with AppTheme {
  final String title;
  final String subTitle;
  final double? subTitleTextSize;
  final VoidCallback onTap;
  final String iconImage;
  final List<Color> colors;

  const ProgressCardWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.subTitleTextSize,
      required this.onTap,
      required this.iconImage,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h28),
              decoration: BoxDecoration(
                color: clr.whiteColor,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: colors,
                    stops: const [
                      0.0,
                      0.7,
                    ]),
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
            Positioned(
                right: 0,
                child: Stack(
                  children: [
                    SvgPicture.asset(ImageAssets.polygon),
                    Positioned(
                        right: 8.w, top: 6, child: Image.asset(iconImage)),
                  ],
                ))
          ],
        ));
  }
}
