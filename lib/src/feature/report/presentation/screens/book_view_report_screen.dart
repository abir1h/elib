import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/book_view_download_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_action_button.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/utility/app_label.dart';
import '../services/book_view_report_screen_service.dart';

class BookVIewDownloadScreen extends StatefulWidget {
  const BookVIewDownloadScreen({Key? key}) : super(key: key);

  @override
  State<BookVIewDownloadScreen> createState() => _BookVIewDownloadScreenState();
}

class _BookVIewDownloadScreenState extends State<BookVIewDownloadScreen>
    with BookViewReportScreenService, AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.bookReport, b: bn.bookReport),
      child: LayoutBuilder(
          builder: (context, constraints) => Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.w16, vertical: size.h16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(ImageAssets.report, height: 200.h),
                        Padding(
                          padding: EdgeInsets.all(size.h8),
                          child: Text(
                            label(e: en.bookReportTitle, b: bn.bookReportTitle),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.textXMedium,
                                fontFamily: StringData.fontFamilyPoppins,
                                color: clr.appPrimaryColorBlack),
                          ),
                        ),
                        SizedBox(height: size.h24),
                        Text(
                          label(e: en.chooseBookReport, b: bn.chooseBookReport),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.textSmall,
                              fontFamily: StringData.fontFamilyPoppins,
                              color: clr.appPrimaryColorBlack),
                        ),
                        SizedBox(height: size.h20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    label(
                                        e: en.calendarStartDate,
                                        b: bn.calendarStartDate),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.textSmall,
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
                                  ),
                                  SizedBox(
                                    height: size.h4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selectStartDate();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.w12,
                                          vertical: size.h8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(size.r8),
                                          border: Border.all(
                                              color:
                                                  clr.lightPrimaryColorPurple)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: clr.lightPrimaryColorPurple,
                                            size: size.r24,
                                          ),
                                          SizedBox(
                                            width: size.w4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              startDate != null
                                                  ? startDate.toString()
                                                  : "DD/MM/YYYY",
                                              style: startDate != null
                                                  ? TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: size.textXSmall,
                                                      fontFamily: StringData
                                                          .fontFamilyPoppins,
                                                      color: clr
                                                          .textColorAppleBlack)
                                                  : TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: size.textXSmall,
                                                      fontFamily: StringData
                                                          .fontFamilyPoppins,
                                                      color:
                                                          clr.calendarHintGrey),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.w32,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    label(
                                        e: en.calendarEndDate,
                                        b: bn.calendarEndDate),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.textSmall,
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
                                  ),
                                  SizedBox(
                                    height: size.h4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selectEndDate();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.w12,
                                          vertical: size.h8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(size.r8),
                                          border: Border.all(
                                              color:
                                                  clr.lightPrimaryColorPurple)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: clr.lightPrimaryColorPurple,
                                            size: size.r24,
                                          ),
                                          SizedBox(
                                            width: size.w4,
                                          ),
                                          Text(
                                            endDate != null
                                                ? endDate.toString()
                                                : "DD/MM/YYYY",
                                            style: endDate != null
                                                ? TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: size.textXSmall,
                                                    fontFamily: StringData
                                                        .fontFamilyPoppins,
                                                    color:
                                                        clr.textColorAppleBlack)
                                                : TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: size.textXSmall,
                                                    fontFamily: StringData
                                                        .fontFamilyPoppins,
                                                    color:
                                                        clr.calendarHintGrey),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.h24,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: size.h10,
                    left: size.h10,
                    right: size.h10,
                    child: GestureDetector(
                      onTap: ()=>navigationTOListScreen(startDate!, endDate!),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.r8),
                            color: startDate != null && endDate != null
                                ?clr.appSecondaryColorPurple: clr.disableColor.withOpacity(.5)
                             ),
                        child: Center(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: size.h8),
                            child: Text(
                              label(e: en.getReport, b: bn.getReport),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.textSmall,color: Colors.white,
                                  fontFamily: StringData.fontFamilyPoppins),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // child: CustomActionButton(
                    //     enabled: startDate != null && endDate != null,
                    //     title: label(e: en.getReport, b: bn.getReport),
                    //     onSuccess: (e) {
                    //       navigationTOListScreen(startDate!,endDate!);
                    //     },
                    //     tapAction: () => getReportList(startDate!, endDate!)),
                  ),
                ],
              )),
    );
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void navigationTOListScreen(String startDate, String endDate) {
    Navigator.of(context).pushNamed(AppRoute.bookViewDownloadCountListScreen,
        arguments:
            BookReportListScreenArgs(startDate: startDate, endDate: endDate));
  }
}

class BookCard extends StatelessWidget with AppTheme, Language {
  final BookViewDownloadDataEntity item;

  BookCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(size.h12),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 8.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150.h, // Set a fixed height for the image
              width: 110.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl:
                      "http://103.209.40.89:82/uploads/${item.book!.coverImage}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Image.asset(ImageAssets.imgPlaceholder),
                  errorWidget: (context, url, error) =>
                      Image.asset(ImageAssets.imgPlaceholder),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
              child: SizedBox(
                height: 150.h,
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.book!.titleEn,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16
                                .sp, // Use ScreenUtil for responsive font size
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          item.book!.descriptionEn,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    )),
                    Container(
                      decoration: BoxDecoration(
                        color: clr.cardStrokeColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.download,
                                  color: clr.appPrimaryColorBlack,
                                ),
                                Text(
                                  item.bookDownload.toString(),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  color: clr.appPrimaryColorBlack,
                                ),
                                Text(
                                  item.viewCount.toString(),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewDownloadListWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const ViewDownloadListWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h4);
      },
    );
  }
}
