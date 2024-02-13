import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/search_book_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/language.dart';
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
      title: "search",
      // label(e: _screenArgs.categoryNameEn, b: _screenArgs.categoryNameBn),
      child: LayoutBuilder(
        builder: (context, constraints) => AppScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBoxWidget(
                hintText: label(e: en.searchText, b: bn.searchText),
                onSearchTermChange: onSearchTermChanged,
              ),
              CheckBoxWidget(
                onValueChanged: (v) => onCheckBoxValue(v.name),
              ),

              ///Results for text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w20),
                child: ResultItemSectionWidget(
                  stream: resultsForStreamController.stream,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.h12),
                child: AppStreamBuilder<List<BookDataEntity>>(
                  stream: bookDataStreamController.stream,
                  loadingBuilder: (context) {
                    return ShimmerLoader(child: Container()
                        // ItemSectionWidget(
                        //     aspectRatio: 1.8,
                        //     title: '',
                        //     items: const ["", "", ""],
                        //     buildItem: (context, index, item) {
                        //       return AspectRatio(
                        //         aspectRatio: .53,
                        //         child: ELibContentItemWidget(
                        //           showBookmark: true,
                        //           item: BookDataEntity(
                        //               id: -1,
                        //               titleEn: "",
                        //               titleBn: "",
                        //               languageEn: "",
                        //               languageBn: "",
                        //               editionEn: "",
                        //               editionBn: "",
                        //               publishYearEn: "",
                        //               publishYearBn: "",
                        //               publisherEn: "",
                        //               publisherBn: "",
                        //               isbnEn: "",
                        //               isbnBn: "",
                        //               slug: "",
                        //               descriptionEn: "",
                        //               descriptionBn: "",
                        //               coverImage: "",
                        //               bookFile: "",
                        //               externalLink: "",
                        //               createdBy: -1,
                        //               isDownload: -1,
                        //               status: -1,
                        //               bookMark: false,
                        //               createdAt: "",
                        //               updatedAt: "",
                        //               deletedAt: "",
                        //               author: [],
                        //               category: []),
                        //           onSelect: (e) {},
                        //           onBookmarkSelect: (e) {},
                        //         ),
                        //       );
                        //     },
                        //     onTapSeeAll: () {})

                        );
                  },
                  dataBuilder: (context, data) {
                    print(data);
                    return Container();
                    // return ItemSectionWidget(
                    //     aspectRatio: 1.8,
                    //     title: 'জনপ্রিয় বই',
                    //     items: data,
                    //     emptyText: "No Book Found !",
                    //     buildItem: (context, index, item) {
                    //       return AspectRatio(
                    //         aspectRatio: .53,
                    //         child: ELibContentItemWidget(
                    //           key: Key(data[index].id.toString()),
                    //           item: data[index],
                    //           onSelect: onBookContentSelected,
                    //           showBookmark: true,
                    //           onBookmarkSelect: onBookmarkContentSelected,
                    //           boxShadow: true,
                    //         ),
                    //       );
                    //     },
                    //     onTapSeeAll: () {});
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showSuccess(String message) {
    // TODO: implement showSuccess
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
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

class SearchCard extends StatelessWidget {
  const SearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
      padding: EdgeInsets.symmetric(horizontal: size.h16),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h16);
      },
    );
  }
}
