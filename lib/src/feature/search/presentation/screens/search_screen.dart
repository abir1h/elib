import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/search_book_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../home/presentation/services/home_service.dart';
import '../services/search_screen_services.dart';
import '../widgets/checkbox_widget.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen>
    with AppTheme, SearchScreenService, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "বই সার্চ করুন",
      child: LayoutBuilder(
        builder: (context, constraints) => AppScrollView(
          padding: EdgeInsets.symmetric(vertical: size.h20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: SearchBoxWidget(
                  hintText: label(e: en.searchText, b: bn.searchText),
                  onSearchTermChange: onSearchTermChanged,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: CheckBoxWidget(
                  onValueChanged: (v) => onCheckBoxValue(v.name),
                ),
              ),

              ///Results for text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: ResultItemSectionWidget(
                  stream: resultsForStreamController.stream,
                ),
              ),

              AppStreamBuilder<List<BookDataEntity>>(
                stream: bookDataStreamController.stream,
                loadingBuilder: (context) {
                  return ShimmerLoader(
                      child: SearchCardSectionWidget(
                    items: const ["", "", "", "", ""],
                    buildItem: (context, index, item) {
                      return SearchCardItemWidget(
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
                      );
                    },
                  ));
                },
                dataBuilder: (context, data) {
                  return SearchCardSectionWidget(
                    items: data,
                    buildItem: (context, index, item) {
                      return SearchCardItemWidget(
                        item: item,
                        onSelect: onTapBook,
                      );
                    },
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
              SizedBox(height: size.h20),
            ],
          ),
        ),
      ),
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

  @override
  void navigateToBookDetailsScreen(BookDataEntity data) {
    Navigator.of(context).pushNamed(
      AppRoute.bookDetailsScreen,
      arguments: BookDetailsScreenArgs(bookData: data),
    );
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
            top: size.h12,
            bottom: size.h8,
          ),
          child: StreamBuilder<DataState<ResultsForViewModel>>(
            stream: stream,
            initialData: DataLoadedState<ResultsForViewModel>(
                ResultsForViewModel.newUploads()),
            builder: (context, snapshot) {
              var data =
                  (snapshot.data! as DataLoadedState<ResultsForViewModel>).data;
              return data.subTitle != 'Showing results for ""'
                  ? Column(
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
                    )
                  : const Offstage();
            },
          ),
        ),
        SizedBox(height: size.h4),
      ],
    );
  }
}

class SearchCardItemWidget extends StatelessWidget with AppTheme {
  final BookDataEntity item;
  final void Function(BookDataEntity item) onSelect;
  final void Function(BookDataEntity item)? onBookmarkSelect;

  const SearchCardItemWidget({
    Key? key,
    required this.item,
    required this.onSelect,
    this.onBookmarkSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(item),
      child: Container(
        padding: EdgeInsets.only(left: size.w16, right: size.w16, top: size.h8),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: size.h1, color: clr.cardStrokeColorLavender)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.w44,
              height: size.h64,
              child: CachedNetworkImage(
                imageUrl: item.coverImage.isNotEmpty
                    ? "http://103.209.40.89:82/${item.coverImage}"
                    : "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D",
                placeholder: (context, url) => const Offstage(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.image, color: clr.greyColor),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: size.w16), // Add space between image and text
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.h16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label(e: item.titleEn, b: item.titleEn),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: clr.textColorAppleBlack,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins,
                    ),
                  ),
                  Text(
                    item.author != null && item.author!.isNotEmpty
                        ? item.author!.map((c) => c.name).toList().join(', ')
                        : "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: clr.colorShadeGrey,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchCardSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const SearchCardSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h8);
      },
    );
  }
}
