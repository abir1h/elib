import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/book_report_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/utility/app_label.dart';
import '../services/book_view_report_list_screen_service.dart';

class BookReportListScreen extends StatefulWidget {
  final Object? arguments;
  const BookReportListScreen({super.key, this.arguments});
  @override
  State<BookReportListScreen> createState() => _BookReportListScreenState();
}

class _BookReportListScreenState extends State<BookReportListScreen>
    with BookViewReportListScreenService, AppTheme, Language {
  @override
  void initState() {
    super.initState();

    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getReportList(widget.arguments as BookReportListScreenArgs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.bookReport, b: bn.bookReport),
      child: LayoutBuilder(
          builder: (context, constraints) =>
              AppStreamBuilder<List<BookReportDataEntity>>(
                stream: reportDataStreamController.stream,
                loadingBuilder: (context) {
                  return ShimmerLoader(
                      child: ListView.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.w16, vertical: size.h20),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 150.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(.5),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: size.h28);
                    },
                  ));
                },
                dataBuilder: (context, data) {
                  return ViewDownloadListWidget(
                      items: data,
                      buildItem: (context, index, item) {
                        return item.book != null
                            ? BookCard(
                                item: item,
                              )
                            : Offstage();
                      });
                },
                emptyBuilder: (context, message, icon) => EmptyWidget(
                  message: message,
                  offset: 350.w,
                  constraints: constraints,
                ),
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
}

class BookCard extends StatelessWidget with AppTheme, Language {
  final BookReportDataEntity item;

  BookCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoute.bookDetailsScreen,
          arguments: BookDetailsScreenArgs(bookData: item.book!),
        );
      },
      child: AspectRatio(
        aspectRatio: 2.2,
        child: Container(
            padding: EdgeInsets.all(size.h12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.r8),
              border: Border(
                  left: BorderSide(
                      color: clr.lightPrimaryColorShadePurple, width: size.w6)),
              color: clr.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: clr.appSecondaryColorPurple.withOpacity(.2),
                  blurRadius: size.r8,
                  offset: Offset(0.0, size.h2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(size.r10),
                  child: CachedNetworkImage(
                    width: 100.w,
                    height: 200.h,
                    imageUrl:
                        "http://103.209.40.89:82/uploads/${item.book!.coverImage}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Image.asset(ImageAssets.imgPlaceholder),
                    errorWidget: (context, url, error) =>
                        Image.asset(ImageAssets.imgPlaceholder),
                  ),
                ),
                SizedBox(width: size.w20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.book!.titleEn,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                      ),
                      SizedBox(height: size.h4),
                      Expanded(
                        child: Text(
                          /*item.book!.author
                                                .map((c) => c.name)
                                                .toList()
                                                .join(', '),*/
                          "সানাউল্লাহ সাগর",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w400,
                              fontFamily: StringData.fontFamilyRoboto),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: clr.whiteColor,
                            borderRadius: BorderRadius.circular(size.r10),
                            border: Border.all(color: clr.colorShadePurple)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.download,
                                    color: clr.appSecondaryColorPurple,
                                  ),
                                  Text(
                                    item.bookDownload.toString(),
                                    style: TextStyle(
                                      fontSize: size.textXXSmall,
                                      color: clr.appSecondaryColorPurple,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: StringData.fontFamilyPoppins,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: clr.appSecondaryColorPurple,
                                  ),
                                  Text(
                                    item.viewCount.toString(),
                                    style: TextStyle(
                                      fontSize: size.textXXSmall,
                                      color: clr.appSecondaryColorPurple,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: StringData.fontFamilyPoppins,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                /* Expanded(
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
              ),*/
              ],
            )),
      ),
    );
/*
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
*/
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
      padding: EdgeInsets.symmetric(horizontal: size.h16),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h16);
      },
    );
  }
}
