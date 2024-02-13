import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/presentation/widgets/book_item_widget.dart';
import '../../../category/presentation/screens/category_details_screen.dart';
import '../services/read_book_screen_service.dart';
import '../../../report/domain/entities/book_report_data_entity.dart';

class ReadBooksScreen extends StatefulWidget {
  const ReadBooksScreen({super.key});

  @override
  State<ReadBooksScreen> createState() => _ReadBooksScreenState();
}

class _ReadBooksScreenState extends State<ReadBooksScreen>
    with AppTheme, Language, ReadBooksScreenService {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "পঠিত বইসমূহ",
        child: LayoutBuilder(
            builder: (context, constraints) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w16, vertical: size.h16),
                  child: AppScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "আমার পড়া বই সমূহ:",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: clr.appPrimaryColorBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w600,
                            fontFamily: StringData.fontFamilyPoppins,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        AppStreamBuilder<List<BookReportDataEntity>>(
                          stream: readBookDataStreamController.stream,
                          loadingBuilder: (context) {
                            return ShimmerLoader(
                                child: ReadBookSectionWidget(
                              items: const ["", "", "", "", "", "", "", "", ""],
                              buildItem:
                                  (BuildContext context, int index, item) {
                                return BookItemWidget(
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
                            return ReadBookSectionWidget(
                              items: data,
                              buildItem:
                                  (BuildContext context, int index, item) {
                                if (data[index].book != null) {
                                  return BookItemWidget(
                                    key: Key(data[index].book!.id.toString()),
                                    item: item.book!,
                                    onSelect: onBookContentSelected,
                                    onBookmarkSelect: onBookmarkSelected,
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            );
                          },
                          emptyBuilder: (context, message, icon) => EmptyWidget(
                            message: message,
                            constraints: constraints,
                            offset: 350.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }

  @override
  void navigateToBookDetailsScreen(BookDataEntity data) {
    Navigator.of(context).pushNamed(
      AppRoute.bookDetailsScreen,
      arguments: BookDetailsScreenArgs(bookData: data),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}
class ReadBookSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const ReadBookSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

  return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.5,
        crossAxisSpacing: size.h12,
        mainAxisSpacing: size.h12,
      ),
      itemCount: items.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: size.h20),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
    );
  }
}