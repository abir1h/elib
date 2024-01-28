import 'package:cached_network_image/cached_network_image.dart';
import 'package:elibrary/src/core/common_widgets/custom_scaffold.dart';
import 'package:elibrary/src/core/constants/app_theme.dart';
import 'package:elibrary/src/core/constants/common_imports.dart';
import 'package:elibrary/src/core/constants/language.dart';
import 'package:elibrary/src/feature/report/domain/entities/book_view_download_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
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
        title: " Report",
        actionChild:  AppStreamBuilder<bool>(
            stream: actionButtonDataStreamController.stream,
            loadingBuilder: (context) {
              return const Offstage();
            },
            dataBuilder: (context, data) {
                  return GestureDetector(
                      onTap: onTapClearButton,
                        // setState(() {
                        //   isStartFilter = false;
                        //   startDate = null;
                        //   endDate = null;
                        //   selectedStartDate = null;
                        // });

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: clr.appPrimaryColorGreen,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                          child: Text(
                            "Clear",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: clr.whiteColor),
                          ),
                        ),
                      ),
                    );
            },
          emptyBuilder: (BuildContext context, String message, IconData icon) {
              return const Offstage();
          },),
        child:LayoutBuilder(
                builder: (context, constraints) =>
                    AppStreamBuilder<List<BookViewDownloadDataEntity>>(
                  stream: reportDataStreamController.stream,
                  loadingBuilder: (context) {
                    return Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.w16, vertical: size.h16),
                                child: Column(
                                  children: [
                                    Lottie.asset(ImageAssets.filterAnim, height: 200.h),
                                    Padding(
                                      padding: EdgeInsets.all(size.h8),
                                      child: Text(
                                        "Get book download & view count report",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.sp,
                                            color: clr.appPrimaryColorGreen),
                                      ),
                                    ),
                                    SizedBox(height: size.h16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              selectStartDate();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: clr.cardStrokeColor,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text(
                                                  startDate != null
                                                      ? startDate.toString()
                                                      : "Select Start Date",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: size.textXSmall),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Text(
                                          'To',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: size.textXSmall),
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              selectEndDate();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: startDate != null
                                                    ? clr.cardStrokeColor
                                                    : clr.disableColor.withOpacity(.5),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text(
                                                        endDate != null
                                                            ? endDate.toString()
                                                            : "Select End Date",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: size.textXSmall))),
                                              ),
                                            ),
                                          ),
                                        )
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
                                child: CustomActionButton(
                                  enabled: startDate != null && endDate != null,
                                    title: label(e: en.getReport, b: bn.getReport),
                                    onSuccess: (e) {

                                    },
                                    tapAction: () => getReportList(startDate!, endDate!)),
                              ),
                            ],);
                  },
                  dataBuilder: (context, data) {
                    return ViewDownloadListWidget(
                        items: data,
                        buildItem: (context, index, item) {
                          return item.book!=null?BookCard(
                            item: item,
                          ):Offstage();
                        });
                  },
                  emptyBuilder: (context, message, icon) => EmptyWidget(
                    message: message,
                    offset: 350.w,
                    constraints: constraints,
                  ),
                ),
              ),
              );
  }

  @override
  void showSuccess(String value) {
    // TODO: implement showSuccess
  }

  @override
  void showWarning(String value) {
    // TODO: implement showWarning
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
                                  color: clr.appPrimaryColorGreen,
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
                                  color: clr.appPrimaryColorGreen,
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
