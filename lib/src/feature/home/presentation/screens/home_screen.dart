import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/search_book_widget.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/presentation/widgets/elib_content_item_widget.dart';
import '../services/home_service.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AppTheme, Language, HomeScreenService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            AppScrollView(
              padding: EdgeInsets.only(bottom: size.h64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.h56),

                  ///Header text and image
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w16),
                    child: Row(
                      children: [
                        ///Header text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label(e: en.appBarText, b: bn.appBarText),
                                style: TextStyle(
                                  color: clr.appSecondaryColorPurple,
                                  fontSize: size.textXLarge,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.h8),
                              Text(
                                label(
                                    e: en.homeHeaderText, b: bn.homeHeaderText),
                                style: TextStyle(
                                  color: clr.appPrimaryColorBlack,
                                  fontWeight: FontWeight.w300,
                                  fontSize: size.textSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: size.w8),

                        ///Header Image
                        SvgPicture.asset(
                          ImageAssets.imgIllustration,
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: size.h16),

                  ///Search Box and Bookmark button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w20),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchBoxWidget(
                            hintText: label(e: en.searchText, b: bn.searchText),
                            onSearchTermChange: onSearchTermChanged,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Results for text
                  /* Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w20),
                    child: ResultItemSectionWidget(
                      stream: resultsForStreamController.stream,
                    ),
                  ),*/

                  ///Content section
                  /*Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.h12),
                    child: AppStreamBuilder<List<BookDataEntity>>(
                      stream: bookDataStreamController.stream,
                      loadingBuilder: (context) {
                        return ShimmerLoader(
                            child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: .5,
                            crossAxisSpacing: size.h12,
                            mainAxisSpacing: size.h12,
                          ),
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ELibContentItemWidget(
                              item: BookDataEntity(
                                  id: -1,
                                  titleEn: "",
                                  titleBn: "",
                                  languageEn: "",
                                  languageBn: "",
                                  editionEn: "",
                                  editionBn: "",
                                  publishYearEn: "",
                                  publishYearBn: "",
                                  publisherEn: "",
                                  publisherBn: "",
                                  isbnEn: "",
                                  isbnBn: "",
                                  slug: "",
                                  descriptionEn: "",
                                  descriptionBn: "",
                                  coverImage: "",
                                  bookFile: "",
                                  externalLink: "",
                                  createdBy: -1,
                                  isDownload: -1,
                                  status: -1,
                                  bookMark: false,
                                  createdAt: "",
                                  updatedAt: "",
                                  deletedAt: "",
                                  author: [],
                                  category: []),
                              onSelect: (e) {},
                              onBookmarkSelect: (e) {},
                            );
                          },
                        ));
                      },
                      dataBuilder: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.h12,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: size.h8),
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: .5,
                                  crossAxisSpacing: size.h12,
                                  mainAxisSpacing: size.h12,
                                ),
                                itemCount: data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ELibContentItemWidget(
                                    key: Key(data[index].id.toString()),
                                    item: data[index],
                                    onSelect: onBookContentSelected,
                                    showBookmark: true,
                                    onBookmarkSelect: onBookmarkContentSelected,
                                    boxShadow: true,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      emptyBuilder: (context, message, icon) {
                        return EmptyWidget(
                          constraints: constraints,
                          message: message,
                          icon: icon,
                          offset: 350.w,
                        );
                      },
                    ),
                  ),*/

                  SizedBox(height: size.h20),

                  ///
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.h12),
                    child: AppStreamBuilder<List<BookDataEntity>>(
                      stream: bookDataStreamController.stream,
                      loadingBuilder: (context) {
                        return ShimmerLoader(
                            child: ItemSectionWidget(
                                aspectRatio: 1.8,
                                title: '',
                                items: const ["", "", ""],
                                buildItem: (context, index, item) {
                                  return AspectRatio(
                                    aspectRatio: .53,
                                    child: ELibContentItemWidget(
                                      showBookmark: true,
                                      item: BookDataEntity(
                                          id: -1,
                                          titleEn: "",
                                          titleBn: "",
                                          languageEn: "",
                                          languageBn: "",
                                          editionEn: "",
                                          editionBn: "",
                                          publishYearEn: "",
                                          publishYearBn: "",
                                          publisherEn: "",
                                          publisherBn: "",
                                          isbnEn: "",
                                          isbnBn: "",
                                          slug: "",
                                          descriptionEn: "",
                                          descriptionBn: "",
                                          coverImage: "",
                                          bookFile: "",
                                          externalLink: "",
                                          createdBy: -1,
                                          isDownload: -1,
                                          status: -1,
                                          bookMark: false,
                                          createdAt: "",
                                          updatedAt: "",
                                          deletedAt: "",
                                          author: [],
                                          category: []),
                                      onSelect: (e) {},
                                      onBookmarkSelect: (e) {},
                                    ),
                                  );
                                },
                                onTapSeeAll: () {}));
                      },
                      dataBuilder: (context, data) {
                        return ItemSectionWidget(
                            aspectRatio: 1.8,
                            title: 'জনপ্রিয় বই',
                            items: data,
                            buildItem: (context, index, item) {
                              return AspectRatio(
                                aspectRatio: .53,
                                child: ELibContentItemWidget(
                                  key: Key(data[index].id.toString()),
                                  item: data[index],
                                  onSelect: onBookContentSelected,
                                  showBookmark: true,
                                  onBookmarkSelect: onBookmarkContentSelected,
                                  boxShadow: true,
                                ),
                              );
                            },
                            onTapSeeAll: () {});
                      },
                      emptyBuilder: (context, message, icon) {
                        return EmptyWidget(
                          constraints: constraints,
                          message: message,
                          icon: icon,
                          offset: 350.w,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: size.h20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.h12),
                    child: ItemSectionWidget(
                        aspectRatio: 3,
                        title: "জনপ্রিয় গ্রন্থকার",
                        items: const ["", "", ""],
                        buildItem: (context, index, item) {
                          return AspectRatio(
                            aspectRatio: 1.1,
                            child: AuthorItemWidget(
                              onTap: onTapAuthor,
                            ),
                          );
                        },
                        onTapSeeAll: onTapAuthorSeeAll),
                  )
                ],
              ),
            ),
            Positioned(
              left: size.w16,
              top: size.h8,
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  padding: EdgeInsets.all(size.r6),
                  decoration: BoxDecoration(
                    color: clr.whiteColor,
                    borderRadius: BorderRadius.circular(size.r12),
                    border: Border.all(color: clr.cardStrokeColorPerfume),
                    boxShadow: [
                      BoxShadow(
                        color: clr.appPrimaryColorBlack.withOpacity(.2),
                        blurRadius: size.r8,
                        offset: Offset(0.0, size.h2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.menu,
                    size: size.r24,
                    color: clr.textColorMidBlack,
                  ),
                ),
              ),
            ),
            Positioned(
              right: size.w16,
              top: size.h8,
              child: InkWell(
                onTap: onTapNotification,
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: clr.appSecondaryColorPurple,
                      size: size.r24,
                    ),
                    Positioned(
                      right: -1,
                      top: 2.w,
                      child: Container(
                        width: size.w12,
                        height: size.h12,
                        decoration: BoxDecoration(
                            color: clr.appSecondaryColorPurple,
                            shape: BoxShape.circle,
                            border: Border.all(color: clr.whiteColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }

  @override
  void navigateToBookDetailsScreen(BookDataEntity data) {
    Navigator.of(context).pushNamed(
      AppRoute.bookDetailsScreen,
      arguments: BookDetailsScreenArgs(bookData: data),
    );
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void navigateToAuthorScreen() {
    Navigator.of(context).pushNamed(AppRoute.authorScreen);
  }

  @override
  void navigateToAuthorDetailsScreen() {
    Navigator.of(context).pushNamed(AppRoute.authorDetailsScreen);
  }

  @override
  void navigateToNotificationScreen() {
    Navigator.of(context).pushNamed(AppRoute.notificationScreen);
  }
}

class ResultItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final Stream<DataState<ResultsForViewModel>> stream;
  const ResultItemSectionWidget({
    Key? key,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Header text
        Padding(
          padding: EdgeInsets.only(
            top: size.h32,
            bottom: size.h8,
          ),
          child: StreamBuilder<DataState<ResultsForViewModel>>(
            stream: stream,
            initialData: DataLoadedState<ResultsForViewModel>(
                ResultsForViewModel.newUploads()),
            builder: (context, snapshot) {
              var data =
                  (snapshot.data! as DataLoadedState<ResultsForViewModel>).data;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                        color: clr.appPrimaryColorBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  if (data.subTitle.isNotEmpty)
                    Text(
                      data.subTitle,
                      style: TextStyle(
                        color: clr.textColorBlack,
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: size.h4),
      ],
    );
  }
}

class CategorySectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const CategorySectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h12);
      },
    );
  }
}

class ItemSectionWidget<T> extends StatelessWidget with AppTheme, Language {
  final String title;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  final VoidCallback onTapSeeAll;
  final double aspectRatio;
  const ItemSectionWidget(
      {Key? key,
      required this.title,
      required this.items,
      required this.buildItem,
      required this.onTapSeeAll,
      this.aspectRatio = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.h8, horizontal: size.w8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.r8),
          color: clr.whiteColor,
          boxShadow: [
            BoxShadow(
              color: clr.appPrimaryColorBlack.withOpacity(.2),
              blurRadius: size.r8,
              offset: Offset(0.0, size.h2),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Header text
          Padding(
            padding: EdgeInsets.only(bottom: size.h8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: clr.appSecondaryColorPurple,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (items.isNotEmpty)
                  GestureDetector(
                    onTap: onTapSeeAll,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.w8, vertical: size.h2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.r4),
                        color: clr.cardFillColorBlueMagenta,
                      ),
                      child: Text(
                        label(e: en.seeAllText, b: bn.seeAllText),
                        style: TextStyle(
                          color: clr.appPrimaryColorBlack,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          ///Items section
          items.isNotEmpty
              ? AspectRatio(
                  aspectRatio: aspectRatio,
                  child: ListView.separated(
                    itemCount: items.length < 5 ? items.length : 5,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildItem(context, index, items[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: size.w12);
                    },
                  ),
                )
              : AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Column(
                    children: [
                      Lottie.asset(ImageAssets.animEmpty, height: size.h56 * 2),
                      Text(
                        "No Book Found !",
                        style: TextStyle(
                            color: clr.appPrimaryColorBlack,
                            fontSize: size.textXSmall),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class AuthorItemWidget extends StatelessWidget with AppTheme, Language {
  final VoidCallback onTap;
  const AuthorItemWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: clr.cardStrokeColorGrey, width: size.r4)),
            child: CircleAvatar(
              radius: 35.r,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                ImageAssets.imgEmptyProfile,
              ),
            ),
          ),
          SizedBox(height: size.h8),
          Text(
            "আব্দুল্লাহ আবু সায়ীদ",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: clr.textColorBlack,
                fontSize: size.textXSmall,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyPoppins),
          ),
        ],
      ),
    );
  }
}
