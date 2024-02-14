import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/book_data_entity.dart';
import '../../domain/entities/tag_data_entity.dart';
import '../services/book_details_services.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../widgets/book_info_item_widget.dart';
import '../widgets/tag_widget.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';

class BookDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const BookDetailsScreen({super.key, this.arguments});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with AppTheme, BookDetailsScreenService, Language {
  @override
  void initState() {
    super.initState();

    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(widget.arguments as BookDetailsScreenArgs);
    });
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "বইয়ের বিবরণ",
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
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    AppScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.h16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Flexible container for image
                              SizedBox(
                                height: .25.sh,
                                width: .45.sw, // Responsive height
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(size.r4),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "http://103.209.40.89:82/uploads/${data.coverImage}",
                                    placeholder: (context, url) =>
                                        Icon(Icons.image, color: clr.greyColor),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.image, color: clr.greyColor),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 16.0.w), // Adjust horizontal spacing

                              // Flexible container for bookmark icon
                              GestureDetector(
                                onTap: () => onBookmarkContentSelected(data),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: size.h8,
                                    horizontal: size.w10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: clr.whiteColor,
                                    border: Border.all(
                                        color: clr.greyStokeColor,
                                        width: size.r1),
                                    borderRadius:
                                        BorderRadius.circular(size.r4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: clr.appPrimaryColorBlack
                                            .withOpacity(0.2),
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
                            ],
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
                            padding: EdgeInsets.symmetric(horizontal: size.h4),
                            child: Container(
                              width: 1.sw,
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                  color: clr.whiteColor,
                                  borderRadius: BorderRadius.circular(size.r16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: clr.appPrimaryColorBlack
                                          .withOpacity(.2),
                                      blurRadius: size.r8,
                                      offset: Offset(0.0, 3),
                                    ),
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.h16,
                                  ),
                                  data.titleEn.isNotEmpty
                                      ? Center(
                                          child: Text(
                                            data.titleEn,
                                            style: TextStyle(
                                                color: clr.appPrimaryColorBlack,
                                                fontWeight: FontWeight.w600,
                                                fontSize: size.textMedium,
                                                fontFamily: StringData
                                                    .fontFamilyPoppins),
                                          ),
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    height: size.h8,
                                  ),
                                  if (data.author!.isNotEmpty)
                                    BookInfoItemWidget(
                                        firstItem:
                                            label(e: en.author, b: bn.author),
                                        secondItem: data.author!
                                            .map((c) => c.name)
                                            .toList()
                                            .join(', ')),
                                  if (data.category!.isNotEmpty)
                                    BookInfoItemWidget(
                                        firstItem:
                                            label(e: en.type, b: bn.type),
                                        secondItem: data.category!
                                            .map((c) => c.name)
                                            .toList()
                                            .join(', ')),
                                  AnimatedSwitcher(
                                    duration: const Duration(
                                        milliseconds:
                                            300), // Adjust the duration as needed
                                    switchInCurve: Curves
                                        .easeInOut, // Animation curve for appearing
                                    switchOutCurve: Curves
                                        .easeInOut, // Animation curve for disappearing
                                    child: isExpanded
                                        ? Column(
                                            key: const Key(
                                                'expanded'), // Key to differentiate between different children of AnimatedSwitcher
                                            children: [
                                              if (data.category!.isNotEmpty)
                                                TagWidget(
                                                  firstItem: label(
                                                      e: en.tag, b: bn.tag),
                                                  secondItem: Wrap(
                                                    children: data.tag!
                                                        .map(
                                                            (c) =>
                                                                GestureDetector(
                                                                  onTap: () =>
                                                                      onTapTag(
                                                                          c),
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                            size.h4),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        bottom:
                                                                            BorderSide(
                                                                          color:
                                                                              clr.appSecondaryColorPurple,
                                                                          width:
                                                                              2.w,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      label(
                                                                          e: c.nameEn,
                                                                          b: c.nameBn),
                                                                      style:
                                                                          TextStyle(
                                                                        color: clr
                                                                            .appPrimaryColorBlack,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            size.textSmall,
                                                                        fontFamily:
                                                                            StringData.fontFamilyPoppins,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ))
                                                        .toList(),
                                                  ),
                                                ),
                                              if (data.languageEn.isNotEmpty)
                                                BookInfoItemWidget(
                                                    firstItem: label(
                                                        e: en.bookLanguage,
                                                        b: bn.bookLanguage),
                                                    secondItem:
                                                        data.languageEn),
                                              if (data.editionEn.isNotEmpty)
                                                BookInfoItemWidget(
                                                    firstItem: label(
                                                        e: en.bookEdition,
                                                        b: bn.bookEdition),
                                                    secondItem: data.editionEn),
                                              if (data.publishYearEn.isNotEmpty)
                                                BookInfoItemWidget(
                                                    firstItem: label(
                                                        e: en.bookPublishYear,
                                                        b: bn.bookPublishYear),
                                                    secondItem:
                                                        data.publishYearEn),
                                              if (data.publisherEn.isNotEmpty)
                                                BookInfoItemWidget(
                                                    firstItem: label(
                                                        e: en.publisher,
                                                        b: bn.publisher),
                                                    secondItem:
                                                        data.publisherEn),
                                              if (data.isbnEn.isNotEmpty)
                                                BookInfoItemWidget(
                                                    firstItem: label(
                                                        e: en.isbnNUmber,
                                                        b: bn.isbnNUmber),
                                                    secondItem: data.isbnEn),
                                            ],
                                          )
                                        : SizedBox(), // Use SizedBox to make sure there's no visual artifact when the column is not expanded
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          label(
                                              e: en.seeMoreBookInfo,
                                              b: bn.seeMoreBookInfo),
                                          style: TextStyle(
                                              color: clr.appPrimaryColorBlack,
                                              fontWeight: FontWeight.w600,
                                              fontSize: size.textMedium,
                                              fontFamily:
                                                  StringData.fontFamilyPoppins),
                                        ),
                                        AnimatedSwitcher(
                                            duration: Duration(
                                                milliseconds:
                                                    300), // Adjust the duration as needed
                                            switchInCurve: Curves
                                                .easeInOut, // Animation curve for appearing
                                            switchOutCurve: Curves
                                                .easeInOut, // Animation curve for disappearing
                                            child: isExpanded
                                                ? Icon(Icons
                                                    .keyboard_arrow_up_sharp)
                                                : Icon(Icons
                                                    .keyboard_arrow_down_sharp))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.h20,
                                  ),
                                  Divider(
                                    color: clr.dividerStrokeColorGrey2,
                                  ),
                                  SizedBox(
                                    height: size.h20,
                                  ),
                                  data.descriptionEn.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.h16),
                                          child: Text(
                                            label(
                                                e: en.description,
                                                b: bn.description),
                                            style: TextStyle(
                                                color: clr.appPrimaryColorBlack,
                                                fontWeight: FontWeight.w700,
                                                fontSize: size.textSmall,
                                                fontFamily:
                                                    StringData.fontFamilyInter),
                                          ),
                                        )
                                      : const SizedBox(),
                                  data.descriptionEn.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.h16),
                                          child: Text(
                                            data.descriptionEn,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color: clr.appPrimaryColorBlack,
                                                fontWeight: FontWeight.w400,
                                                fontSize: size.textSmall,
                                                fontFamily:
                                                    StringData.fontFamilyInter),
                                          ),
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    height: size.h32,
                                  )
                                ],
                              ),
                            ),
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

  @override
  void navigateToTagBooksScreen(TagDataEntity tagDataEntity) {
    Navigator.of(context).pushNamed(
      AppRoute.tagBookScreen,
      arguments: TagBookScreenArgs(tagDataEntity: tagDataEntity),
    );
  }
}
