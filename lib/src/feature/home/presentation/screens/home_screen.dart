import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../report/domain/entities/book_report_data_entity.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/search_book_widget.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../author/domain/entities/author_data_entity.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/presentation/widgets/book_item_widget.dart';
import '../services/home_service.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/home_data_entity.dart';

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
                  GestureDetector(
                    onTap: onTapSearchScreen,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.w16),
                      child: Container(
                        width: double.maxFinite,
                        height: size.h42,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.h12, vertical: size.h4),
                        decoration: BoxDecoration(
                          color: clr.whiteColor,
                          border: Border.all(
                            color: clr.cardStrokeColorPerfume,
                            // width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(size.h12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.h2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: size.h2),
                                  child: Icon(
                                    Icons.search_rounded,
                                    color: clr.iconColorGray85,
                                    size: size.h20,
                                  )),
                              SizedBox(width: size.h8),
                              Expanded(
                                  child: Text(
                                "Search by title, author",
                                style: TextStyle(
                                    color: clr.textColorSilverSconce,
                                    fontSize: size.textSmall,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: StringData.fontFamilyPoppins),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          ),
                        ),
                      ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.h12),
                    child: AppStreamBuilder<HomeDataEntity>(
                      stream: homeDataStreamController.stream,
                      loadingBuilder: (context) {
                        return Column(
                          children: [
                            ShimmerLoader(
                                child: ItemSectionWidget(
                                    title: "",
                                    items: const ["", ""],
                                    buildItem: (context, index, item) =>
                                        const AspectRatio(aspectRatio: .4),
                                    onTapSeeAll: () {})),
                            SizedBox(height: size.h12),
                            ShimmerLoader(
                                child: ItemSectionWidget(
                                    title: "",
                                    items: const ["", ""],
                                    buildItem: (context, index, item) =>
                                        const AspectRatio(aspectRatio: .4),
                                    onTapSeeAll: () {})),
                            SizedBox(height: size.h12),
                            ShimmerLoader(
                                child: ItemSectionWidget(
                                    title: "",
                                    items: const ["", ""],
                                    buildItem: (context, index, item) =>
                                        const AspectRatio(aspectRatio: .4),
                                    onTapSeeAll: () {})),
                          ],
                        );
                      },
                      dataBuilder: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///Latest Book
                            ItemSectionWidget(
                                aspectRatio: 1.45,
                                title: label(
                                    e: en.latestBookHomeText,
                                    b: bn.latestBookHomeText),
                                items: data.latestBook,
                                emptyText: "No Book Found !",
                                buildItem: (context, index, item) {
                                  return AspectRatio(
                                    aspectRatio: .45,
                                    child: BookItemWidget(
                                      key: Key(item.id.toString()),
                                      item: item,
                                      onSelect: onBookContentSelected,
                                      onBookmarkSelect:
                                          onBookmarkContentSelected,
                                    ),
                                  );
                                },
                                onTapSeeAll: () =>
                                    onTapLatestSeeAll(data.latestBook)),

                            ///Most Viewed Book
                            ItemSectionWidget(
                                aspectRatio: 1.45,
                                title: label(
                                    e: en.mostViewedBookHomeText,
                                    b: bn.mostViewedBookHomeText),
                                items: data.mostViewedBooks.where((element) => element.book != null).toList(),
                                emptyText: "No Book Found !",
                                buildItem: (context, index, item) {
                                  return item.book != null ? AspectRatio(
                                    aspectRatio: .45,
                                    child: BookItemWidget(
                                      key: Key(item.id.toString()),
                                      item: item.book!,
                                      onSelect: onBookContentSelected,
                                      onBookmarkSelect:
                                      onBookmarkContentSelected,
                                    ),
                                  ) : const Offstage();
                                },
                                onTapSeeAll: () =>
                                    onTapMostViewedSeeAll(data.mostViewedBooks.where((element) => element.book != null).toList())),

                            ///First Category
                            CategorySectionWidget(
                                items: data.categories,
                                buildItem: (context, index, item) =>
                                    ItemSectionWidget(
                                      aspectRatio: 1.45,
                                      title: label(e: item.nameEn, b: item.nameBn),
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
                                    )),

                            ///Author
                            // ItemSectionWidget(
                            //   aspectRatio: 2.5,
                            //   title: "জনপ্রিয় লেখক",
                            //   contentPaddingSize: size.h24,
                            //   items: data.authors,
                            //   horizontalPadding: size.w12,
                            //   verticalPadding: size.h12,
                            //   emptyText: "No Author Found !",
                            //   boxDecoration: true,
                            //   buildItem: (context, index, item) {
                            //     return AspectRatio(
                            //       aspectRatio: .85,
                            //       child: AuthorItemWidget(
                            //         authorDataEntity: item,
                            //         onTap: () => onTapAuthor(item),
                            //       ),
                            //     );
                            //   },
                            //   onTapSeeAll: onTapAuthorSeeAll,
                            // ),

                            SizedBox(height: size.h20),

                            ///Second Category
                            CategorySectionWidget(
                                items: data.categoriesTwo,
                                buildItem: (context, index, item) =>
                                    ItemSectionWidget(
                                      aspectRatio: 1.45,
                                      title: item.name,
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
                                    )),
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
                  ),

                  ///
                  /*Padding(
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
                            emptyText: "No Book Found !",
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
                      child: AppStreamBuilder<List<AuthorDataEntity>>(
                        stream: authorDataStreamController.stream,
                        loadingBuilder: (context) {
                          return ShimmerLoader(
                              child: ItemSectionWidget(
                                  aspectRatio: 2.5,
                                  title: "জনপ্রিয় গ্রন্থকার",
                                  items: const ["", "", ""],
                                  buildItem: (context, index, item) {
                                    return AspectRatio(
                                      aspectRatio: 1.1,
                                      child: AuthorItemWidget(
                                        authorDataEntity:
                                            const AuthorDataEntity(
                                          id: -1,
                                          authorTypeId: -1,
                                          name: "",
                                          slug: "",
                                          email: "",
                                          phone: "",
                                          address: "",
                                          country: "",
                                          photo: "",
                                          status: -1,
                                          createdAt: "",
                                          updatedAt: "",
                                          deletedAt: "",
                                        ),
                                        onTap: () {},
                                      ),
                                    );
                                  },
                                  onTapSeeAll: () {}));
                        },
                        dataBuilder: (context, data) {
                          return ItemSectionWidget(
                            aspectRatio: 2.5,
                            title: "জনপ্রিয় গ্রন্থকার",
                            items: data,
                            horizontalPadding: size.w12,
                            verticalPadding: size.h16,
                            emptyText: "No Author Found !",
                            buildItem: (context, index, item) {
                              return AuthorItemWidget(
                                authorDataEntity: item,
                                onTap: () => onTapAuthor(item),
                              );
                            },
                            onTapSeeAll: onTapAuthorSeeAll,
                          );
                        },
                        emptyBuilder: (context, message, icon) => EmptyWidget(
                          message: message,
                          constraints: constraints,
                          offset: 350.w,
                        ),
                      ))*/
                ],
              ),
            ),
            Positioned(
              left: size.w12,
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
    CustomToasty.of(context).showWarning(message);
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
  void navigateToAllAuthorScreen() {
    Navigator.of(context).pushNamed(AppRoute.authorScreen);
  }

  @override
  void navigateToAuthorBooksScreen(AuthorDataEntity authorDataEntity) {
    Navigator.of(context).pushNamed(AppRoute.authorBooksScreen,
        arguments: AuthorBookScreenArgs(authorDataEntity: authorDataEntity));
  }

  @override
  void navigateToNotificationScreen() {
    Navigator.of(context).pushNamed(AppRoute.notificationScreen);
  }

  @override
  void navigateToCategoryDetailsScreen(
      String categoryNameEn, String categoryNameBn, int id) {
    Navigator.of(context).pushNamed(
      AppRoute.categoryDetailsScreen,
      arguments: CategoryDetailsScreenArgs(
          categoryNameEn: categoryNameEn,
          categoryNameBn: categoryNameBn,
          categoryId: id),
    );
  }

  @override
  void navigateToLatestBookScreen(List<BookDataEntity> items) {
    Navigator.of(context).pushNamed(
      AppRoute.latestBookScreen,
      arguments: LatestBookScreenArgs(items: items),
    );
  }

  @override
  void navigateToSearchScreen() {
    Navigator.of(context).pushNamed(
      AppRoute.searchScreen,
    );
  }

  @override
  void navigateToMostViewedBookScreen(List<BookReportDataEntity> items) {
    Navigator.of(context).pushNamed(
      AppRoute.mostViewedBookScreen,
      arguments: MostViewedBookScreenArgs(items: items),
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
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 0.0);
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
  final double horizontalPadding;
  final double verticalPadding;
  final String emptyText;
  final bool boxDecoration;
  final double? contentPaddingSize;
  const ItemSectionWidget(
      {Key? key,
      required this.title,
      required this.items,
      required this.buildItem,
      required this.onTapSeeAll,
      this.aspectRatio = 2,
      this.horizontalPadding = 0.0,
      this.verticalPadding = 0.0,
      this.emptyText = "No Item Found",
      this.boxDecoration = false,
      this.contentPaddingSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      decoration: boxDecoration
          ? BoxDecoration(
              color: clr.whiteColor,
              borderRadius: BorderRadius.circular(size.r8),
              boxShadow: [
                BoxShadow(
                  color: clr.appPrimaryColorBlack.withOpacity(.2),
                  blurRadius: size.r8,
                  offset: Offset(0.0, size.h6),
                ),
              ],
            )
          : BoxDecoration(color: clr.whiteColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Header text
          Row(
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
                        horizontal: size.w8, vertical: size.h4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.r4),
                      color: clr.cardFillColorBlueMagenta,
                      boxShadow: [
                        BoxShadow(
                          color: clr.appPrimaryColorBlack.withOpacity(.2),
                          blurRadius: size.r1,
                          offset: Offset(0, size.r1 * 2),
                        ),
                      ],
                    ),
                    child: Text(
                      label(e: en.seeAllText, b: bn.seeAllText),
                      style: TextStyle(
                        color: clr.appPrimaryColorBlack,
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: contentPaddingSize ?? size.h12),

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
                      return SizedBox(width: size.w20);
                    },
                  ),
                )
              : AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Column(
                    children: [
                      Lottie.asset(ImageAssets.animEmpty,
                          height: size.h56 * 1.2),
                      Text(
                        emptyText,
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
  final AuthorDataEntity authorDataEntity;
  final VoidCallback onTap;
  const AuthorItemWidget(
      {super.key, required this.authorDataEntity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: clr.cardStrokeColorGrey, width: size.r4)),
            child: CircleAvatar(
              radius: 28..r,
              backgroundColor: Colors.transparent,
              child: CachedNetworkImage(
                imageUrl: authorDataEntity.photo.isNotEmpty
                    ? "http://103.209.40.89:8012/uploads/${authorDataEntity.photo}"
                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQNL_ZnOTpXSvhf1UaK7beHey2BX42U6solRA&usqp=CAU",
                placeholder: (context, url) => const Offstage(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.image, color: clr.greyColor),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: size.h8),
          Text(
            authorDataEntity.nameEn,
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
