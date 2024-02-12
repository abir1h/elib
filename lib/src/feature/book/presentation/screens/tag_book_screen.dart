import 'package:elibrary/src/core/utility/app_label.dart';
import 'package:elibrary/src/feature/book/domain/entities/book_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../category/presentation/screens/category_details_screen.dart';
import '../services/tag_book_screen_service.dart';
import '../widgets/elib_content_item_widget.dart';

class TagBookScreen extends StatefulWidget {
  final Object? arguments;
  const TagBookScreen({super.key, this.arguments});

  @override
  State<TagBookScreen> createState() => _TagBookScreenState();
}

class _TagBookScreenState extends State<TagBookScreen>
    with AppTheme, Language, TagBookScreenService {
  late TagBookScreenArgs _screenArgs;

  @override
  void initState() {
    _screenArgs = widget.arguments as TagBookScreenArgs;
    super.initState();

    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadTagBooksData(_screenArgs.tagDataEntity.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(
          e: _screenArgs.tagDataEntity.nameEn,
          b: _screenArgs.tagDataEntity.nameBn),
      child: LayoutBuilder(
          builder: (context, constraints) => Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: AppScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppStreamBuilder<List<BookDataEntity>>(
                        stream: tagBooksDataStreamController.stream,
                        loadingBuilder: (context) {
                          return ShimmerLoader(
                              child: BookSectionWidget(
                            items: const ["", "", "", "", "", "", "", "", ""],
                            buildItem: (BuildContext context, int index, item) {
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
                            buildItem: (BuildContext context, int index, item) {
                              return ELibContentItemWidget(
                                showBookmark: true,
                                key: Key(data[index].id.toString()),
                                item: data[index],
                                onSelect: onBookContentSelected,
                                onBookmarkSelect: onBookmarkSelected,
                                boxShadow: true,
                              );
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
              )),
    );
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
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
