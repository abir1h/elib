import 'package:flutter/material.dart';

import '../../../../core/utility/app_label.dart';
import '../services/most_viewed_book_screen_service.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/presentation/widgets/book_item_widget.dart';
import '../../../category/presentation/widgets/book_section_widget.dart';

class MostViewedBookScreen extends StatefulWidget {
  final Object? arguments;
  const MostViewedBookScreen({super.key, this.arguments});

  @override
  State<MostViewedBookScreen> createState() => _MostViewedBookScreenState();
}

class _MostViewedBookScreenState extends State<MostViewedBookScreen>
    with AppTheme, Language, MostViewedBookScreenService {
  late MostViewedBookScreenArgs _screenArgs;

  @override
  void initState() {
    _screenArgs = widget.arguments as MostViewedBookScreenArgs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.mostViewedBookHomeText, b: bn.mostViewedBookHomeText),
      child: LayoutBuilder(
        builder: (context, constraints) => AppScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label(e: en.mostViewedAllBookText, b: bn.mostViewedAllBookText),
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
              BookSectionWidget(
                items: _screenArgs.items,
                buildItem: (BuildContext context, int index, item) {
                  return BookItemWidget(
                    key: Key(item.id.toString()),
                    item: item.book!,
                    onSelect: (e) => onBookContentSelected(e),
                    onBookmarkSelect: (e) {},

                    // onSelect: onBookContentSelected,
                    // onBookmarkSelect: onBookmarkSelected,
                  );
                },
              )
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
  void showSuccess(String message) {
    // TODO: implement showSuccess
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}
