import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../../../book/presentation/widgets/elib_content_item_widget.dart';
import '../services/category_screen_service.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../domain/entities/category_data_entity.dart';
import '../../../../core/common_widgets/header_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with AppTheme, Language, CategoriesScreenService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
                title: label(e: en.categoriesText, b: bn.categoriesText)),
            Expanded(
              child: AppStreamBuilder<List<CategoryDataEntity>>(
                stream: categoryDataStreamController.stream,
                loadingBuilder: (context) {
                  return ShimmerLoader(
                      child: CategorySectionWidget(
                          items: const ["", "", ""],
                          buildItem: (context, index, item) {
                            return ItemSectionWidget<String>(
                              onTapSeeAll: () {},
                              title: "                    ",
                              items: const [
                                "",
                                "",
                              ],
                              buildItem: (context, index, item) {
                                return AspectRatio(
                                  aspectRatio: .8,
                                  child: ELibContentItemWidget(
                                    key: ObjectKey(item),
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
                                  ),
                                );
                              },
                            );
                          }));
                },
                dataBuilder: (context, data) {
                  return CategorySectionWidget(
                      items: data,
                      buildItem: (context, index, item) {
                        return ItemSectionWidget(
                            title: data[index].name,
                            items: data[index].books,
                            buildItem: (context, index, item) {
                              return AspectRatio(
                                aspectRatio: .6,
                                child: ELibContentItemWidget(
                                  key: Key(item.id.toString()),
                                  item: item,
                                  onSelect: onBookContentSelected,
                                ),
                              );
                            },
                            onTapSeeAll: () =>
                                onTapSeeAll(data[index].name, data[index].id));
                      });
                },
                emptyBuilder: (context, message, icon) => EmptyWidget(
                  message: message,
                  constraints: constraints,
                  offset: 350.w,
                ),
              ),
            ),
            SizedBox(height: size.h64)
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
  void navigateToCategoryDetailsScreen(String categoryName, int id) {
    Navigator.of(context).pushNamed(
      AppRoute.categoryDetailsScreen,
      arguments:
          CategoryDetailsScreenArgs(categoryName: categoryName, categoryId: id),
    );
  }

  @override
  void navigateToBookDetailsScreen(BookDataEntity data) {
    Navigator.of(context).pushNamed(
      AppRoute.bookDetailsScreen,
      arguments: BookDetailsScreenArgs(bookData: data),
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
              color: clr.blackColor.withOpacity(.2),
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
                      color: clr.appPrimaryColorGreen,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (items.isNotEmpty)
                  GestureDetector(
                    onTap: onTapSeeAll,
                    child: Text(
                      label(e: en.seeAllText, b: bn.seeAllText),
                      style: TextStyle(
                        color: clr.appPrimaryColorGreen,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w400,
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
                            color: clr.appPrimaryColorGreen,
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

class ShimmerLoaderItemWidget extends StatelessWidget with AppTheme {
  final BookDataEntity data;
  final void Function(BookDataEntity bookDataEntity) onSelect;
  final double aspectRatio;
  const ShimmerLoaderItemWidget(
      {Key? key,
      required this.onSelect,
      required this.data,
      this.aspectRatio = .8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: GestureDetector(
        onTap: () => onSelect(data),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.h8),
            border: Border.all(
              color: clr.appPrimaryColorGreen.withOpacity(.1),
              width: size.w1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size.r8),
            child: Stack(
              children: [
                ///Thumbnail image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.5),
                  child: CachedNetworkImage(
                    cacheKey: data.coverImage.split("/").last,
                    imageUrl: data.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),

                ///Content title
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.maxFinite,
                    color: Colors.black.withOpacity(0.7),
                    padding: EdgeInsets.all(size.h8),
                    child: Text(
                      data.titleEn,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: clr.whiteColor,
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      /*ClipRRect(
        borderRadius: BorderRadius.circular(size.r16),
        child: GestureDetector(
          onTap: () => onSelect(data),
          child: Container(
            decoration: BoxDecoration(
              color: clr.shadowBlack,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ///Thumbnails
                if (data.imagePath.isNotEmpty)
                  CachedNetworkImage(
                    cacheKey: data.imagePath.split("/").last,
                    imageUrl: data.imagePath,
                    fit: BoxFit.cover,
                  ),

                ///Black shader
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(size.s8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(.1),
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      //  stops: const [0.0,0.5,0.7],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Item title
                      Text(
                        data.title,
                        style: TextStyle(
                          color: clr.textWhiteNormal,
                          fontSize: size.textMedium,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            BoxShadow(
                              color: clr.controlBlackDeep,
                              blurRadius: size.s4,
                              spreadRadius: 1.w,
                              offset: Offset(1.w, 1.w),
                            ),
                            BoxShadow(
                              color: clr.controlBlackDeep,
                              spreadRadius: 1.w,
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: size.s8,
                      ),

                      ///Rating and content counts
                      Row(
                        children: [
                          ///Rating
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.s8, vertical: 3.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.5),
                              borderRadius: BorderRadius.circular(6.w),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  data.rating.toStringAsFixed(1),
                                  style: TextStyle(
                                    color: clr.textWhiteNormal,
                                    fontSize: size.textXXSmall,
                                    fontWeight: FontWeight.w300,
                                    // height: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: size.s4,
                                ),
                                Icon(
                                  Icons.star,
                                  color: clr.textYellowLight,
                                  size: 13.w,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),

                          ///Content counts
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.s8, vertical: size.s4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.5),
                              borderRadius: BorderRadius.circular(6.w),
                            ),
                            child: Text(
                              "${data.noOfContents} Content${data.noOfContents > 1 ? "s" : ""}",
                              style: TextStyle(
                                color: clr.textWhiteNormal,
                                fontSize: size.textXXSmall,
                                fontWeight: FontWeight.w300,
                                // height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),*/
    );
  }
}
