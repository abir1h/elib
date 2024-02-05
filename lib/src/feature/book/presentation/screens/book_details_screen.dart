import 'package:cached_network_image/cached_network_image.dart';
import 'package:elibrary/src/core/constants/language.dart';
import 'package:elibrary/src/core/utility/app_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/book_data_entity.dart';
import '../services/book_details_services.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/custom_toasty.dart';

class BookDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const BookDetailsScreen({super.key, this.arguments});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with AppTheme, BookDetailsScreenService,Language {
  @override
  void initState() {
    super.initState();

    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(widget.arguments as BookDetailsScreenArgs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Book Details',
      child: AppStreamBuilder<BookDataEntity>(
        stream: bookDataStreamController.stream,
        loadingBuilder: (context) {
          return const Center(
            child: CircularLoader(),
          );
        },
        dataBuilder: (context, data) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.h16),
            child: Column(
              children: [
                Expanded(
                    child: Stack(
                  fit: StackFit.expand,clipBehavior: Clip.none,
                  children: [
                    AppScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.h16,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w), // Adjust horizontal padding
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Flexible container for image
                                Flexible(
                                  flex: 2, // Adjust the flex value as needed
                                  child: SizedBox(
                                    height:230.h, // Responsive height
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl: "http://103.209.40.89:82/uploads/${data.coverImage}",
                                        placeholder: (context, url) => const Offstage(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.image, color: clr.greyColor),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.0.w), // Adjust horizontal spacing

                                // Flexible container for bookmark icon
                                Flexible(
                                  flex: 1, // Adjust the flex value as needed
                                  child: GestureDetector(
                                    onTap: () => onBookmarkContentSelected(data),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.0.h,
                                        horizontal: 10.0.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: clr.whiteColor,
                                        border: Border.all(color: clr.greyStokeColor, width: 1.0),
                                        borderRadius: BorderRadius.circular(4.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 3,
                                            offset: const Offset(0.0, 2),
                                          ),
                                        ],
                                      ),
                                      child: data.bookMark
                                          ? Icon(
                                        Icons.bookmark,
                                        color: clr.appSecondaryColorPurple,
                                        size: 24.0,
                                      )
                                          : Icon(
                                        Icons.bookmark_border_outlined,
                                        color: clr.appSecondaryColorPurple,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /* Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [


                                  ///Bookmark
                                  Positioned(
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () =>
                                          onBookmarkContentSelected(data),
                                      child: Container(
                                          margin: EdgeInsets.all(size.h2),
                                          padding: EdgeInsets.all(size.h2),
                                          decoration: BoxDecoration(
                                            color: clr.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(size.r4),
                                          ),
                                          child: data.bookMark
                                              ? Icon(
                                                  Icons.bookmark,
                                                  color:
                                                      clr.appPrimaryColorBlack,
                                                )
                                              : Icon(
                                                  Icons
                                                      .bookmark_border_outlined,
                                                  color:
                                                      clr.appPrimaryColorBlack,
                                                )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: size.w10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    data.titleEn.isNotEmpty
                                        ? Text(
                                            data.titleEn,
                                            style: TextStyle(
                                                color: clr.appPrimaryColorBlack,
                                                fontWeight: FontWeight.w600,
                                                fontSize: size.textLarge,
                                                fontFamily: StringData
                                                    .fontFamilyPoppins),
                                          )
                                        : const SizedBox(),
                                    data.author.isNotEmpty
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text.rich(
                                              TextSpan(
                                                text: data.author.isNotEmpty
                                                    ? "By "
                                                    : "",
                                                children: [
                                                  TextSpan(
                                                    text: data.author
                                                        .map((c) => c.name)
                                                        .toList()
                                                        .join(', '),
                                                    style: TextStyle(
                                                      color: clr
                                                          .appPrimaryColorBlack,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: StringData
                                                          .fontFamilyPoppins,
                                                      fontSize: size.textXSmall,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: TextStyle(
                                                  color:
                                                      clr.textColorAppleBlack,
                                                  fontSize: size.textXXSmall,
                                                  fontFamily: StringData
                                                      .fontFamilyPoppins),
                                            ),
                                          )
                                        : const SizedBox(),
                                    data.category.isNotEmpty
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text.rich(
                                              TextSpan(
                                                text: data.category.isNotEmpty
                                                    ? "Category : "
                                                    : "",
                                                children: [
                                                  TextSpan(
                                                    text: data
                                                        .category.first.name
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: clr
                                                            .appPrimaryColorBlack,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            size.textSmall,
                                                        fontFamily: StringData
                                                            .fontFamilyPoppins),
                                                  ),
                                                ],
                                              ),
                                              style: TextStyle(
                                                color: clr.textColorAppleBlack,
                                                fontSize: size.textXSmall,
                                                fontFamily: StringData
                                                    .fontFamilyPoppins,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    data.publisherEn.isNotEmpty
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text.rich(
                                              TextSpan(
                                                text:
                                                    data.publisherEn.isNotEmpty
                                                        ? "Publisher : "
                                                        : "",
                                                children: [
                                                  TextSpan(
                                                    text: data.publisherEn,
                                                    style: TextStyle(
                                                      color: clr
                                                          .appPrimaryColorBlack,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: size.textSmall,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: TextStyle(
                                                color: clr.textColorAppleBlack,
                                                fontSize: size.textXSmall,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    data.editionEn.isNotEmpty
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text.rich(
                                              TextSpan(
                                                text: data.editionEn.isNotEmpty
                                                    ? "Edition : "
                                                    : "",
                                                children: [
                                                  TextSpan(
                                                    text: data.editionEn,
                                                    style: TextStyle(
                                                      color: clr
                                                          .textColorAppleBlack,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: size.textSmall,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: TextStyle(
                                                color: clr.textColorAppleBlack,
                                                fontSize: size.textXSmall,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              )
                            ],
                          ),*/
                          SizedBox(
                            height: size.h32,
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: size.h4),
                            child: Container(

                              width: 1.sw,
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                              color: clr.whiteColor,
                              borderRadius: BorderRadius.circular(size.r16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.2),
                                      blurRadius: size.r8,
                                      offset: Offset(0.0, 3),
                                    ),
                                  ]
                              ),child: Column(
                              children: [
                                data.titleEn.isNotEmpty
                                    ? Text(
                                  data.titleEn,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.textMedium,
                                      fontFamily: StringData.fontFamilyPoppins),
                                )
                                    : const SizedBox(),
                                SizedBox(height: size.h8,),
                                if(data.author.isNotEmpty)

                                Padding(
                                  padding: EdgeInsets.only(left: 26.w,right: 26.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 3,
                                        child: Text(
                                          label(e: en.author, b: bn.bookPublishYear),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: size.textSmall,
                                            fontFamily: StringData.fontFamilyPoppins,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal:size.w12),
                                        child: Text(
                                          ":",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.textSmall,
                                            fontFamily: StringData.fontFamilyPoppins,
                                          ),
                                        ),
                                      ),
                                      Expanded(flex: 4,
                                        child: Text(
                                         data.titleEn,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.textSmall,
                                            fontFamily: StringData.fontFamilyPoppins,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 26.w,right: 26.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 35,
                                        child: Text(
                                          label(e: en.bookPublishYear, b: bn.bookPublishYear),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: size.textSmall,
                                            fontFamily: StringData.fontFamilyPoppins,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal:size.w8),
                                        child: Text(
                                          ":",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.textSmall,
                                            fontFamily: StringData.fontFamilyPoppins,
                                          ),
                                        ),
                                      ),
                                      Expanded(flex: 60,
                                        child: Text(
                                         data.titleEn,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.textSmall,
                                            fontFamily: StringData.fontFamilyPoppins,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: size.h32,),
                              ],
                            ),
                            ),
                          ),
                          data.descriptionEn.isNotEmpty
                              ? Text(
                                  "Description",
                                  style: TextStyle(
                                      color: clr.appPrimaryColorBlack,
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.textMedium,
                                      fontFamily: StringData.fontFamilyPoppins),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: size.h16,
                          ),
                          Text(
                            data.descriptionEn + data.descriptionEn,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: clr.appPrimaryColorBlack,
                                fontWeight: FontWeight.normal,
                                fontSize: size.textSmall,
                                fontFamily: StringData.fontFamilyPoppins),
                          ),
                          SizedBox(
                            height: size.h64 * 2 + size.h24,
                          ),
                          // Text("Book Title: ${data.titleEn}"),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          color: clr.whiteColor,
                          child: CustomButton(
                            onTap: () => onNavigateToBookViewerScreen(
                                (widget.arguments as BookDetailsScreenArgs)
                                    .bookData),
                            title: "Read Book",
                          ),
                        ),
                        Container(
                          height: size.h8,
                          color: clr.whiteColor,
                        ),
                        Container(
                          color: clr.whiteColor,
                          child: CustomButton(
                              onTap: () {
                                downloadFile(
                                    "http://103.209.40.89:82/uploads/${data.bookFile}",
                                    filename: data.bookFile
                                        .substring(
                                            data.bookFile.lastIndexOf("/") + 1)
                                        .replaceAll("?", "")
                                        .replaceAll("=", ""));
                              },
                              title: "Download Book"),
                        ),
                        Container(
                          height: size.h32,
                          color: clr.whiteColor,
                        ),
                      ],
                    )
                  ],
                ))
              ],
            ),
          );
        },
        emptyBuilder: (context, message, _) => const Offstage(),
      ),
    );
  }

  @override
  void navigateToBookViewerScreen(BookDataEntity item) {
    Navigator.of(context).pushNamed(
      AppRoute.bookViewScreen,
      arguments: BookViewerScreenArgs(
        // docId: item.id.toString(),
        bookId: item.id,
        title: item.titleEn,
        canDownload: item.isDownload == 1 ? true : false,
        url: "http://103.209.40.89:82/uploads/${item.bookFile}",
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}
