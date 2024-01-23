import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elibrary/src/core/constants/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/search_book_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../services/home_service.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';

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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.h20),
        child: LayoutBuilder(
          builder: (context, constraints) => AppScrollView(
            padding: EdgeInsets.only(bottom: size.h64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Header text and image
                Row(
                  children: [
                    ///Header text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label(e: en.appBarText, b: bn.appBarText),
                            style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textXLarge,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: size.h8),
                          Text(
                            label(e: en.homeHeaderText, b: bn.homeHeaderText),
                            style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontWeight: FontWeight.w200,
                              fontSize: size.textSmall,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///Header Image
                    SizedBox(
                      width: size.h64 * 2,
                      height: size.h64 * 2,
                      child: Image.asset(ImageAssets.imageHome,
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.h12,
                ),

                ///Search Box and Bookmark button
                Row(
                  children: [
                    Expanded(
                      child: SearchBoxWidget(
                        hintText: label(e: en.searchText, b: bn.searchText),
                        onSearchTermChange: onSearchTermChanged,
                      ),
                    ),
                  ],
                ),

                ///Results for text
                ItemSectionWidget(
                  stream: resultsForStreamController.stream,
                ),

                ///Content section
                AppStreamBuilder<List<BookDataEntity>>(
                  stream: bookDataStreamController.stream,
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
                        GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: .6,
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
                            );
                          },
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
              ],
            ),
          ),
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
}

class ItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final Stream<DataState<ResultsForViewModel>> stream;
  const ItemSectionWidget({
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
                        color: clr.appPrimaryColorGreen,
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

class ELibContentItemWidget extends StatefulWidget with AppTheme {
  final void Function(BookDataEntity item) onSelect;
  final void Function(BookDataEntity item)? onBookmarkSelect;
  final BookDataEntity item;
  final bool? showBookmark;
  const ELibContentItemWidget({
    Key? key,
    required this.onSelect,
    required this.item,
    this.onBookmarkSelect,  this.showBookmark,
  }) : super(key: key);

  @override
  State<ELibContentItemWidget> createState() => _ELibContentItemWidgetState();
}

class _ELibContentItemWidgetState extends State<ELibContentItemWidget>
    with AppTheme {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              // color: clr.iconColorRed,
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
                        imageUrl: widget.item.coverImage.isNotEmpty
                            ? "http://103.209.40.89:82/uploads/${widget.item.coverImage}"
                            : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQNL_ZnOTpXSvhf1UaK7beHey2BX42U6solRA&usqp=CAU",
                        placeholder: (context, url) => const Offstage(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.image, color: clr.greyColor),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  ///Bookmark
                  widget.showBookmark!=null?Align(
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
                          child: widget.item.bookMark
                              ? Icon(
                                  Icons.bookmark,
                                  color: clr.appPrimaryColorGreen,
                                )
                              : Icon(
                                  Icons.bookmark_border_outlined,
                                  color: clr.appPrimaryColorGreen,
                                )),
                    ),
                  ):const Offstage(),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: size.h4),
        GestureDetector(
          onTap: () => widget.onSelect(widget.item),
          child: Text(
            widget.item.titleEn,
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
                text: widget.item.author.isNotEmpty ? "by " : "",
                style: TextStyle(
                    color: clr.placeHolderTextColorGray,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                    text: widget.item.author
                        .map((c) => c.name)
                        .toList()
                        .join(', '),
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
