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
import '../../../book/presentation/widgets/elib_content_item_widget.dart';
import '../services/category_details_screen_service.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';

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
              AppStreamBuilder<List<BookDataEntity>>(
                stream: bookDataStreamController.stream,
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
                        onSelect: onBookContentSelected,
                        onBookmarkSelect: onBookmarkSelected,
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

class BookSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const BookSectionWidget(
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
