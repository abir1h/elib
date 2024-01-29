import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/header_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/bookmark_data_entity.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../services/bookmark_screen_service.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/language.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen>
    with AppTheme, Language, BookmarkScreenService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(title: label(e: en.bookmarkText, b: bn.bookmarkText)),
            Expanded(
              child: AppStreamBuilder<List<BookmarkDataEntity>>(
                stream: bookmarkDataStreamController.stream,
                loadingBuilder: (context) {
                  return ShimmerLoader(
                      child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: .5,
                      crossAxisSpacing: size.h12,
                      mainAxisSpacing: size.h12,
                    ),
                    itemCount: 10,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.w12, vertical: size.h12),
                    itemBuilder: (context, index) {
                      return BookmarkItemWidget(
                        item: BookmarkDataEntity(
                            id: -1,
                            bookId: -1,
                            emisUserId: -1,
                            createdAt: "",
                            updatedAt: "",
                            deletedAt: "",
                            status: -1,
                            book: BookDataEntity(
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
                                category: [])),
                        onSelect: (e) {},
                        onBookmarkSelect: (e) {},
                      );
                    },
                  ));
                },
                dataBuilder: (context, data) {
                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.5,
                      crossAxisSpacing: size.h12,
                      mainAxisSpacing: size.h12,
                    ),
                    itemCount: data.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.w12, vertical: size.h12),
                    itemBuilder: (context, index) {
                      return BookmarkItemWidget(
                        key: Key(data[index].id.toString()),
                        item: data[index],
                        onSelect: onBookContentSelected,
                        onBookmarkSelect: onBookmarkContentSelected,
                      );
                      return Container();
                    },
                  );
                },
                emptyBuilder: (context, message, icon) => EmptyWidget(
                  message: message,
                  constraints: constraints,
                  offset: 350.w,
                ),
              ),
            ),
            SizedBox(height: size.h64),
          ],
        ),
      ),
    );
  }

  @override
  void navigateToBookDetailsScreen(BookmarkDataEntity data) {
    Navigator.of(context).pushNamed(
      AppRoute.bookDetailsScreen,
      arguments: BookDetailsScreenArgs(bookData: data.book!),
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

class BookmarkItemWidget extends StatefulWidget with AppTheme {
  final void Function(BookmarkDataEntity item) onSelect;
  final void Function(BookmarkDataEntity item)? onBookmarkSelect;
  final BookmarkDataEntity item;
  const BookmarkItemWidget(
      {Key? key,
      required this.onSelect,
      required this.item,
      this.onBookmarkSelect})
      : super(key: key);

  @override
  State<BookmarkItemWidget> createState() => _ELibContentItemWidgetState();
}

class _ELibContentItemWidgetState extends State<BookmarkItemWidget>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.r8),
          color: clr.cardFillColorBlue,
          boxShadow: [
            BoxShadow(
              color: clr.blackColor.withOpacity(.2),
              blurRadius: size.r8,
              offset: Offset(0.0, size.h2),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.h8),
                border: Border.all(
                  color: clr.appPrimaryColorGreen.withOpacity(.1),
                  width: 1.w,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7.w),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ///Thumbnail image
                    GestureDetector(
                      onTap: () => widget.onSelect(widget.item),
                      child: Container(
                        width: double.infinity,
                        // height: double.infinity,
                        color: Colors.grey.withOpacity(0.5),
                        child: CachedNetworkImage(
                          imageUrl: widget.item.book!.coverImage.isNotEmpty
                              ? "http://103.209.40.89:82/uploads/${widget.item.book?.coverImage}"
                              : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQNL_ZnOTpXSvhf1UaK7beHey2BX42U6solRA&usqp=CAU",
                          placeholder: (context, url) => const Offstage(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.image, color: clr.greyColor),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    ///Bookmark
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: widget.onBookmarkSelect != null
                            ? () => widget.onBookmarkSelect!(widget.item)
                            : () {},
                        child: Container(
                            margin: EdgeInsets.all(size.h2),
                            padding: EdgeInsets.all(size.h2),
                            decoration: BoxDecoration(
                              color: clr.whiteColor,
                              borderRadius: BorderRadius.circular(size.r4),
                            ),
                            child: Icon(
                              Icons.bookmark,
                              color: clr.appPrimaryColorGreen,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: size.h6),
          Expanded(
            child: GestureDetector(
              onTap: () => widget.onSelect(widget.item),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.h4),
                child: Text(
                  widget.item.book != null ? widget.item.book!.titleEn : "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Text.rich(
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                  text: widget.item.book!.author.isNotEmpty ? "by " : "",
                  style: TextStyle(
                      color: clr.appPrimaryColorGreen,
                      fontSize: size.textXXSmall,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: widget.item.book != null
                          ? widget.item.book!.author
                              .map((c) => c.name)
                              .toList()
                              .join(', ')
                          : "",
                      style: TextStyle(
                          color: clr.textColorBlack,
                          fontSize: size.textXXSmall,
                          fontWeight: FontWeight.w600),
                    ),
                  ])),
        ],
      ),
    );
  }
}
