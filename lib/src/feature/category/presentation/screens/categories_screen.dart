import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../services/category_screen_service.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../domain/entities/category_data_entity.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with AppTheme, CategoriesScreenService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => AppScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStreamBuilder<List<CategoryDataEntity>>(
                stream: categoryDataStreamController.stream,
                loadingBuilder: (context) {
                  return const CircularLoader();
                },
                dataBuilder: (context, data) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: data.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.w12, vertical: size.h12),
                    itemBuilder: (context, index) {
                      return ItemSectionWidget(
                          title: data[index].name,
                          items: data[index].books,
                          buildItem: (context, index, item) {
                            return AspectRatio(
                              aspectRatio: .8,
                              child: ELibContentItemWidget(
                                key: Key(item.id.toString()),
                                item: item,
                                onSelect: onBookContentSelected,
                              ),
                            );
                          },
                          onTapSeeAll: () =>
                              onTapSeeAll(data[index].name, data[index].books));
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: size.h12);
                    },
                  );
                },
                emptyBuilder: (context, message, icon) {
                  return const Text("Empty");
                },
              ),
              SizedBox(height: size.h64)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void navigateToCategoryDetailsScreen(
      String categoryName, List<BookDataEntity> data) {
    Navigator.of(context).pushNamed(
      AppRoute.categoryDetailsScreen,
      arguments:
          CategoryDetailsScreenArgs(categoryName: categoryName, books: data),
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

class ItemSectionWidget<T> extends StatelessWidget with AppTheme {
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
      this.aspectRatio = 2.4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Header text
        Padding(
          padding: EdgeInsets.only(
              left: size.w16, right: size.w16, top: size.h12, bottom: size.h8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: clr.blackColor,
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
                    'See all',
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
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
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
                child: Center(
                  child: Text(
                    "No Book Found",
                    style: TextStyle(color: clr.textColorAppleBlack),
                  ),
                ),
              ),
      ],
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