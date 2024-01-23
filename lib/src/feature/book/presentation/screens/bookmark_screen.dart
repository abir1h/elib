import 'package:cached_network_image/cached_network_image.dart';
import 'package:elibrary/src/core/common_widgets/shimmer_loader.dart';
import 'package:elibrary/src/core/constants/language.dart';
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
import '../services/bookmark_screen_service.dart';
import '../../../book/domain/entities/book_data_entity.dart';

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
                      childAspectRatio: .6,
                      crossAxisSpacing: size.h12,
                      mainAxisSpacing: size.h12,
                    ),
                    itemCount: 10,
                    shrinkWrap: true,
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
                      childAspectRatio: 0.6,
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
                    },
                  );

                  // return  Expanded(
                  //   child: Container(
                  //     color: Colors.deepOrange,
                  // child: GridView.builder(
                  //           physics: const BouncingScrollPhysics(),
                  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             childAspectRatio: 0.7,
                  //             crossAxisSpacing: size.h12,
                  //             mainAxisSpacing: size.h12,
                  //           ),
                  //           itemCount: data.length,
                  //           shrinkWrap: false,
                  //           itemBuilder: (context, index) {
                  //             return Container();
                  //           },
                  //         ),
                  // )
                  // );
                  ///Item widget
                  // return Column(
                  //   children: [
                  //     Expanded(
                  //         child: GridView.builder(
                  //           physics: const BouncingScrollPhysics(),
                  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             childAspectRatio: 0.7,
                  //             crossAxisSpacing: size.h12,
                  //             mainAxisSpacing: size.h12,
                  //           ),
                  //           itemCount: data.length,
                  //           shrinkWrap: false,
                  //           itemBuilder: (context, index) {
                  //             return Container();
                  //           },
                  //         ))
                  //   ],
                  // );
                },
                emptyBuilder: (context, message, icon) => EmptyWidget(
                  message: message,
                  constraints: constraints,
                  offset: 350.w,
                ),
              ),
            ),
            SizedBox(height: size.h64),

            ///Search Box and Bookmark button
            // Row(
            //   children: [
            //     Expanded(
            //       child: SearchBoxWidget(
            //         hintText: "Search..",
            //         onSearchTermChange: onSearchTermChanged,
            //         serviceState: serviceState,
            //       ),
            //     ),
            //     CategoryFilterMenu(
            //       serviceState: serviceState,
            //       onLoadData: onLoadCategoryList,
            //       onCategorySelected: onCategorySelected,
            //     ),
            //   ],
            // ),

            // ///Results for text
            // ItemSectionWidget(
            //   stream: resultsForStreamController.stream,
            // ),
            // ///Content section
            // AppStreamBuilder<PaginatedGridViewController<BookDataEntity>>(
            //   stream: eLibraryDataStreamController.stream,
            //   loadingBuilder: (x)=>
            //
            //       CircularProgressIndicator(),
            //   //     SectionLoadingWidget(
            //   //   constraints: constraints,
            //   //   offset: 350.w,
            //   // ),
            //   dataBuilder: (context, data){
            //     ///Item widget
            //     return PaginatedGridView<PaginatedGridViewController<BookDataEntity>>(
            //       controller: paginationController,
            //       physics: const BouncingScrollPhysics(),
            //       shrinkWrap: true,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2,
            //         childAspectRatio: 0.7,
            //         crossAxisSpacing: size.h12,
            //         mainAxisSpacing: size.h12,
            //       ),
            //       itemBuilder: (context, item, index) {
            //         return Container();
            //
            //         //   ELibContentItemWidget(
            //         //   // key: Key(item.id.toString()),
            //         //   item: item,
            //         //   onSelect: onELibraryContentSelected,
            //         // );
            //       },
            //       loaderBuilder: (context)=> Padding(
            //         padding: EdgeInsets.all(4.0.w),
            //         child: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       ),
            //     );
            //   },
            //   emptyBuilder: (context, message,icon){
            //     return CircularProgressIndicator();
            //
            //     //   SectionEmptyWidget(
            //     //   constraints: constraints,
            //     //   message: message,
            //     //   icon: icon,
            //     //   offset: 350.w,
            //     // );
            //   },
            // ),
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
  void navigateToBookDetailsScreen(BookmarkDataEntity data) {
    Navigator.of(context).pushNamed(
      AppRoute.bookDetailsScreen,
      arguments: BookDetailsScreenArgs(bookData: data.book!),
    );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
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
        SizedBox(height: size.h4),
        GestureDetector(
          onTap: () => widget.onSelect(widget.item),
          child: Text(
            widget.item.book != null ? widget.item.book!.titleEn : "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: clr.appPrimaryColorGreen,
              fontSize: size.textXXSmall,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text.rich(
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            TextSpan(
                text: widget.item.book!.author.isNotEmpty ? "by " : "",
                style: TextStyle(
                    color: clr.placeHolderTextColorGray,
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
                        color: clr.textColorAppleBlack,
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w600),
                  ),
                ])),
      ],
    );
  }
}
