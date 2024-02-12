import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/presentation/widgets/elib_content_item_widget.dart';
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
                        /*AuthorItemWidget(
                          authorDataEntity: _screenArgs.authorDataEntity,
                          onTap: () {},
                        ),*/
                        AppStreamBuilder<List<BookReportDataEntity>>(
                          stream: readBookDataStreamController.stream,
                          loadingBuilder: (context) {
                            return ShimmerLoader(
                                child: BookSectionWidget(
                              items: const ["", "", "", "", "", "", "", "", ""],
                              buildItem:
                                  (BuildContext context, int index, item) {
                                return ELibContentItemWidget(
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
                                  boxShadow: true,
                                );
                              },
                            ));
                          },
                          dataBuilder: (context, data) {
                            return BookSectionWidget(
                              items: data,
                              buildItem:
                                  (BuildContext context, int index, item) {
                                if (data[index].book != null) {
                                  return ELibContentItemWidget(
                                    showBookmark: true,
                                    key: Key(data[index].book!.id.toString()),
                                    item: item.book!,
                                    onSelect: onBookContentSelected,
                                    onBookmarkSelect: onBookmarkSelected,
                                    boxShadow: true,
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