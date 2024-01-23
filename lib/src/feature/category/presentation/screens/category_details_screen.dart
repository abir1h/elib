import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../services/category_details_screen_service.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const CategoryDetailsScreen({super.key, this.arguments});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen>
    with AppTheme, CategoryDetailsScreenService {
  late CategoryDetailsScreenArgs _screenArgs;

  @override
  void initState() {
    _screenArgs = widget.arguments as CategoryDetailsScreenArgs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: _screenArgs.categoryName,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
          crossAxisSpacing: size.h12,
          mainAxisSpacing: size.h12,
        ),
        itemCount: _screenArgs.books.length,
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ELibContentItemWidget(
            key: Key(_screenArgs.books[index].id.toString()),
            item: _screenArgs.books[index],
            onSelect: onBookContentSelected,
          );
        },
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
}
