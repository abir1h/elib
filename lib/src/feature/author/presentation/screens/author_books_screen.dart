import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/presentation/widgets/book_item_widget.dart';
import '../../../category/presentation/widgets/book_section_widget.dart';
import '../services/author_books_screen_service.dart';
import 'author_screen.dart';

class AuthorBooksScreen extends StatefulWidget {
  final Object? arguments;
  const AuthorBooksScreen({super.key, this.arguments});

  @override
  State<AuthorBooksScreen> createState() => _AuthorBooksScreenState();
}

class _AuthorBooksScreenState extends State<AuthorBooksScreen>
    with AppTheme, Language, AuthorBooksScreenService {
  late AuthorBookScreenArgs _screenArgs;

  @override
  void initState() {
    _screenArgs = widget.arguments as AuthorBookScreenArgs;
    super.initState();

    ///Initially load course details
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadAuthorBooksData(_screenArgs.authorDataEntity.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: _screenArgs.authorDataEntity.nameEn,
        child: LayoutBuilder(
            builder: (context, constraints) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w16, vertical: size.h16),
                  child: AppScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthorItemWidget(
                          authorDataEntity: _screenArgs.authorDataEntity,
                          subTitle: "সকল বই সমূহ",
                          onTap: () {},
                        ),
                        SizedBox(height: size.h20),
                        AppStreamBuilder<List<BookDataEntity>>(
                          stream: authorBooksDataStreamController.stream,
                          loadingBuilder: (context) {
                            return ShimmerLoader(
                                child: BookSectionWidget(
                              items: const ["", "", "", "", "", "", "", "", ""],
                              buildItem:
                                  (BuildContext context, int index, item) {
                                return BookItemWidget(
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
                                );
                              },
                            ));
                          },
                          dataBuilder: (context, data) {
                            return BookSectionWidget(
                              items: data,
                              buildItem:
                                  (BuildContext context, int index, item) {
                                return BookItemWidget(
                                  key: Key(data[index].id.toString()),
                                  item: data[index],
                                  onSelect: onBookContentSelected,
                                  onBookmarkSelect: onBookmarkSelected,
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
