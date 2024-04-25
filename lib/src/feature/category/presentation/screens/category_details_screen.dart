import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/presentation/widgets/book_item_widget.dart';
import '../services/category_details_screen_service.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/book_section_widget.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const CategoryDetailsScreen({super.key, this.arguments});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen>
    with AppTheme, CategoryDetailsScreenService, Language {
  late CategoryDetailsScreenArgs _screenArgs;

  @override
  void initState() {
    _screenArgs = widget.arguments as CategoryDetailsScreenArgs;
    loadBookListData(_screenArgs.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title:
          label(e: _screenArgs.categoryNameEn, b: _screenArgs.categoryNameBn),
      child: LayoutBuilder(
        builder: (context, constraints) => AppScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label(e: en.categoryViewAll, b: bn.categoryViewAll),
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
              SizedBox(height: size.h20),
              AppStreamBuilder<List<BookDataEntity>>(
                stream: bookDataStreamController.stream,
                loadingBuilder: (context) {
                  return ShimmerLoader(
                      child: BookSectionWidget(
                    items: const ["", "", "", "", "", "", "", "", ""],
                    buildItem: (BuildContext context, int index, item) {
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
                            isbn: "",
                            slug: "",
                            descriptionEn: "",
                            descriptionBn: "",
                            coverImage: "",
                            bookFile: "",
                            hasExternalLink: false,
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
                        onSelect: onBookContentSelected,
                        onBookmarkSelect: onBookmarkSelected,
                      );
                    },
                  ));
                },
                dataBuilder: (context, data) {
                  return BookSectionWidget(
                    items: data,
                    buildItem: (BuildContext context, int index, item) {
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
      ),
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
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}
