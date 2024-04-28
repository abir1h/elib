import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../domain/entities/book_data_entity.dart';
import '../../domain/entities/book_details_data_entity.dart';
import '../../domain/entities/tag_data_entity.dart';
import '../services/book_details_services.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../widgets/book_info_item_widget.dart';
import '../widgets/book_item_widget.dart';
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

    ///Initially load book details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadInitialData(widget.arguments as BookDetailsScreenArgs);
    });
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.bookDetailsText, b: bn.bookDetailsText),
      child: AppStreamBuilder<BookDetailsDataEntity>(
        stream: bookDataStreamController.stream,
        loadingBuilder: (context) {
          return const Center(
            child: CircularLoader(),
          );
        },
        dataBuilder: (context, data) {
          return Column(
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.w16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(flex: 23, child: Container()),
                              Expanded(
                                  flex: 54,
                                  child: AspectRatio(
                                    aspectRatio: .84,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                clr.greyColor.withOpacity(.8),
                                            blurRadius: size.r16,
                                            offset: Offset(0.0, size.r12),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(size.r4),
                                        child: CachedNetworkImage(
                                          imageUrl: data.bookDetails.coverImage
                                                  .isNotEmpty
                                              ? "http://103.209.40.89:8012/uploads/${data.bookDetails.coverImage}"
                                              : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQNL_ZnOTpXSvhf1UaK7beHey2BX42U6solRA&usqp=CAU",
                                          placeholder: (context, url) => Icon(
                                              Icons.image,
                                              color: clr.greyColor),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.image,
                                                  color: clr.greyColor),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                flex: 23,
                                child: GestureDetector(
                                  onTap: () => onBookmarkContentSelected(
                                      data.bookDetails),
                                  child: SizedBox(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.h16 + size.h2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.h8),
                                      decoration: BoxDecoration(
                                        color: clr.whiteColor,
                                        border: Border.all(
                                            color: clr.greyStokeColor,
                                            width: size.r1),
                                        borderRadius:
                                            BorderRadius.circular(size.r8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: clr.appPrimaryColorBlack
                                                .withOpacity(0.2),
                                            blurRadius: 3,
                                            offset: const Offset(0.0, 2),
                                          ),
                                        ],
                                      ),
                                      child: data.bookDetails.bookMark
                                          ? Icon(
                                              Icons.bookmark,
                                              color:
                                                  clr.appSecondaryColorPurple,
                                              size: size.h24,
                                            )
                                          : Icon(
                                              Icons.bookmark_border_outlined,
                                              color:
                                                  clr.appSecondaryColorPurple,
                                              size: size.h24,
                                            ),
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
                          padding: EdgeInsets.symmetric(horizontal: size.h20),
                          child: Container(
                            width: 1.sw,
                            clipBehavior: Clip.none,
                            decoration: BoxDecoration(
                              color: clr.whiteColor,
                              borderRadius: BorderRadius.circular(size.r16),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      clr.appPrimaryColorBlack.withOpacity(.2),
                                  blurRadius: size.r8,
                                  offset: Offset(0.0, size.h6),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.h16,
                                ),
                                data.bookDetails.titleEn.isNotEmpty
                                    ? Center(
                                        child: Text(
                                          data.bookDetails.titleEn,
                                          style: TextStyle(
                                              color: clr.appPrimaryColorBlack,
                                              fontWeight: FontWeight.w600,
                                              fontSize: size.textMedium,
                                              fontFamily:
                                                  StringData.fontFamilyPoppins),
                                        ),
                                      )
                                    : const SizedBox(),
                                SizedBox(
                                  height: size.h8,
                                ),
                                if (data.bookDetails.author!.isNotEmpty)
                                  BookInfoItemWidget(
                                      firstItem:
                                          label(e: en.author, b: bn.author),
                                      secondItem: data.bookDetails.author!
                                          .map((c) => c.nameEn)
                                          .toList()
                                          .join(', ')),
                                if (data.bookDetails.category!.isNotEmpty)
                                  BookInfoItemWidget(
                                      firstItem: label(e: en.type, b: bn.type),
                                      secondItem: data.bookDetails.category!
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
                                            if (data
                                                .bookDetails.tag!.isNotEmpty)
                                              TagWidget(
                                                firstItem:
                                                    label(e: en.tag, b: bn.tag),
                                                secondItem: Wrap(
                                                  children: data
                                                      .bookDetails.tag!
                                                      .map((c) =>
                                                          GestureDetector(
                                                            onTap: () =>
                                                                onTapTag(c),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom: size
                                                                          .h1),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    color: clr
                                                                        .appSecondaryColorPurple,
                                                                    width: 2.w,
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
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: size
                                                                      .textXSmall,
                                                                  fontFamily:
                                                                      StringData
                                                                          .fontFamilyPoppins,
                                                                ),
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                            if (data.bookDetails.languageEn
                                                .isNotEmpty)
                                              BookInfoItemWidget(
                                                  firstItem: label(
                                                      e: en.bookLanguage,
                                                      b: bn.bookLanguage),
                                                  secondItem: data
                                                      .bookDetails.languageEn),
                                            if (data.bookDetails.editionEn
                                                .isNotEmpty)
                                              BookInfoItemWidget(
                                                  firstItem: label(
                                                      e: en.bookEdition,
                                                      b: bn.bookEdition),
                                                  secondItem: data
                                                      .bookDetails.editionEn),
                                            if (data.bookDetails.publishYearEn
                                                .isNotEmpty)
                                              BookInfoItemWidget(
                                                  firstItem: label(
                                                      e: en.bookPublishYear,
                                                      b: bn.bookPublishYear),
                                                  secondItem: data.bookDetails
                                                      .publishYearEn),
                                            if (data.bookDetails.publisherEn
                                                .isNotEmpty)
                                              BookInfoItemWidget(
                                                  firstItem: label(
                                                      e: en.publisher,
                                                      b: bn.publisher),
                                                  secondItem: data
                                                      .bookDetails.publisherEn),
                                            if (data
                                                .bookDetails.isbn.isNotEmpty)
                                              BookInfoItemWidget(
                                                  firstItem: label(
                                                      e: en.isbnNUmber,
                                                      b: bn.isbnNUmber),
                                                  secondItem:
                                                      data.bookDetails.isbn),
                                          ],
                                        )
                                      : const SizedBox(), // Use SizedBox to make sure there's no visual artifact when the column is not expanded
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          duration: const Duration(
                                              milliseconds:
                                                  300), // Adjust the duration as needed
                                          switchInCurve: Curves
                                              .easeInOut, // Animation curve for appearing
                                          switchOutCurve: Curves
                                              .easeInOut, // Animation curve for disappearing
                                          child: isExpanded
                                              ? const Icon(
                                                  Icons.keyboard_arrow_up_sharp)
                                              : const Icon(Icons
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
                                data.bookDetails.descriptionEn.isNotEmpty
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
                                data.bookDetails.descriptionEn.isNotEmpty
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.h16),
                                        child: Text(
                                          data.bookDetails.descriptionEn,
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
                          height: size.h32,
                        ),
                        /// Category book
                        data.categoryBook != null && data.categoryBook!.isNotEmpty ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.w20),
                          child: CategorySectionWidget(
                              items: data.categoryBook!,
                              buildItem: (context, index, item) =>
                                  item.books.isNotEmpty ? ItemSectionWidget(
                                    aspectRatio: 1.45,
                                    title: label(e: en.bookCategoryViewAll, b: bn.bookCategoryViewAll),
                                    items: item.books,
                                    emptyText: "No Book Found !",
                                    buildItem: (context, index, item) {
                                      return AspectRatio(
                                        aspectRatio: .47,
                                        child: BookItemWidget(
                                          key: Key(item.id.toString()),
                                          item: item,
                                          onSelect: onBookContentSelected,
                                          onBookmarkSelect:
                                          onBookmarkContentSelected,
                                        ),
                                      );
                                    },
                                    onTapSeeAll: () => onTapCategory(
                                        item.nameEn, item.nameBn, item.id),
                                  ) : const Offstage()),
                        ) : Container(),

                        ///Author Book List
                        data.authorBook != null && data.authorBook!.isNotEmpty ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.w20),
                          child: ItemSectionWidget(
                              aspectRatio: 1.45,
                              title: label(
                                  e: en.bookAuthorViewAll,
                                  b: bn.bookAuthorViewAll),
                              items: data.authorBook!,
                              emptyText: "No Book Found !",
                              buildItem: (context, index, item) {
                                return item.authorBook != null ? AspectRatio(
                                  aspectRatio: .45,
                                  child: BookItemWidget(
                                    key: Key(item.id.toString()),
                                    item: item.authorBook!,
                                    onSelect: onBookContentSelected,
                                    onBookmarkSelect:
                                    onBookmarkContentSelected,
                                  ),
                                ) : const Offstage();
                              },
                              onTapSeeAll: () => {}),
                        ) : Container(),

                        SizedBox(
                          height: size.h64 * 2 + size.h24,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (data.bookDetails.bookFile.isNotEmpty)
                          Container(
                            color: clr.whiteColor,
                            child: CustomButton(
                              onTap: () {
                                onUserBookViewCountAction(
                                    (widget.arguments as BookDetailsScreenArgs)
                                        .bookData);
                                onNavigateToBookViewerScreen(
                                    (widget.arguments as BookDetailsScreenArgs)
                                        .bookData);
                              },
                              title: "Read Book",
                            ),
                          ),
                        Container(
                          height: size.h8,
                          color: clr.whiteColor,
                        ),
                        if (!data.bookDetails.hasExternalLink &&
                            data.bookDetails.isDownload == 1)
                          Container(
                            color: clr.whiteColor,
                            child: CustomButton(
                                onTap: () {
                                  onUserBookDownloadCountAction(
                                      data.bookDetails);
                                  downloadFile(
                                      "http://103.209.40.89:8012/uploads/${data.bookDetails.bookFile}",
                                      filename: data.bookDetails.bookFile
                                          .substring(data.bookDetails.bookFile
                                                  .lastIndexOf("/") +
                                              1)
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
                    ),
                  )
                ],
              ))
            ],
          );
        },
        emptyBuilder: (context, message, _) => const Offstage(),
      ),
    );
  }

  @override
  void navigateToBookViewerScreen(BookDataEntity item) {
    if (item.hasExternalLink) {
      Navigator.of(context).pushNamed(
        AppRoute.externalBookViewScreen,
        arguments: ExternalBookViewScreenArgs(
          title: item.titleEn,
          url: item.externalLink,
        ),
      );
    } else {
      Navigator.of(context).pushNamed(
        AppRoute.bookViewScreen,
        arguments: BookViewerScreenArgs(
          // docId: item.id.toString(),
          bookId: item.id,
          title: item.titleEn,
          canDownload: item.isDownload == 1 ? true : false,
          url: "http://103.209.40.89:8012/uploads/${item.bookFile}",
        ),
      );
    }
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

  @override
  void navigateToBookDetailsScreen(BookDataEntity data) {
    Navigator.of(context).pushNamed(
      AppRoute.bookDetailsScreen,
      arguments: BookDetailsScreenArgs(bookData: data),
    );
  }

  @override
  void navigateToCategoryDetailsScreen(String categoryNameEn, String categoryNameBn, int id) {
    Navigator.of(context).pushNamed(
      AppRoute.categoryDetailsScreen,
      arguments: CategoryDetailsScreenArgs(
          categoryNameEn: categoryNameEn,
          categoryNameBn: categoryNameBn,
          categoryId: id),
    );
  }
}
