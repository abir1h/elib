import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../services/category_screen_service.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../domain/entities/category_data_entity.dart';
import '../../../../core/common_widgets/header_widget.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with AppTheme, Language, CategoriesScreenService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              title: label(e: en.categoriesText, b: bn.categoriesText),
              onTapNotification: onTapNotification,
            ),
            Expanded(
              child: AppScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: size.w16, vertical: size.h16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "বইয়ের সকল ক্যাটেগরিগুলো দেখুন:",
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
                    AppStreamBuilder<List<CategoryDataEntity>>(
                      stream: categoryDataStreamController.stream,
                      loadingBuilder: (context) {
                        return ShimmerLoader(
                            child: CategorySectionWidget(
                                items: const [
                              "",
                              "",
                              "",
                              "",
                              "",
                              "",
                              "",
                              "",
                              "",
                              "",
                              "",
                              ""
                            ],
                                buildItem:
                                    (BuildContext context, int index, item) {
                                  return CategoryItemWidget(
                                    data: CategoryDataEntity(
                                      id: -1,
                                      parentId: -1,
                                      name: "",
                                      nameEn: "",
                                      nameBn: "",
                                      slug: "",
                                      image: "",
                                      status: -1,
                                      createdAt: "",
                                      updatedAt: "",
                                      deletedAt: "",
                                      books: [],
                                      children: [],
                                    ),
                                    onTap: () {},
                                  );
                                }));
                      },
                      dataBuilder: (context, data) {
                        return CategorySectionWidget(
                            items: data,
                            buildItem: (BuildContext context, int index, item) {
                              return CategoryItemWidget(
                                data: item,
                                onTap: () => onTapCategory(
                                    item.nameEn, item.nameBn, item.id),
                              );
                            });
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
            SizedBox(height: size.h64)
          ],
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void navigateToCategoryDetailsScreen(
      String categoryNameEn, String categoryNameBn, int id) {
    Navigator.of(context).pushNamed(
      AppRoute.categoryDetailsScreen,
      arguments: CategoryDetailsScreenArgs(
          categoryNameEn: categoryNameEn,
          categoryNameBn: categoryNameBn,
          categoryId: id),
    );
  }

  @override
  void navigateToNotificationScreen() {
    Navigator.of(context).pushNamed(AppRoute.notificationScreen);
  }
}

class CategorySectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const CategorySectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: size.w16,
        mainAxisSpacing: size.h16,
      ),
      itemCount: items.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: size.h16),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
    );
  }
}

class CategoryItemWidget<T> extends StatelessWidget with AppTheme, Language {
  final CategoryDataEntity data;
  final VoidCallback onTap;
  const CategoryItemWidget({Key? key, required this.data, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: clr.cardFillColorPlaceboPurple,
            borderRadius: BorderRadius.circular(size.r4),
            border: Border.all(color: clr.cardStrokeColorBlueMagenta)),
        alignment: Alignment.center,
        child: Text(
          label(e: data.nameEn, b: data.nameBn),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: clr.appPrimaryColorBlack,
            fontSize: size.textXSmall,
            fontWeight: FontWeight.w500,
            fontFamily: StringData.fontFamilyPoppins,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
