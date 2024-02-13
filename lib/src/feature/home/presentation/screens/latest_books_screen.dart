import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../book/presentation/widgets/book_item_widget.dart';
import '../../../category/presentation/widgets/book_section_widget.dart';

class LatestBookScreen extends StatefulWidget {
  final Object? arguments;
  const LatestBookScreen({super.key, this.arguments});

  @override
  State<LatestBookScreen> createState() => _LatestBookScreenState();
}

class _LatestBookScreenState extends State<LatestBookScreen>
    with AppTheme, Language {
  late LatestBookScreenArgs _screenArgs;

  @override
  void initState() {
    _screenArgs = widget.arguments as LatestBookScreenArgs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "সাম্প্রতিক বই সমূহ",
      child: LayoutBuilder(
        builder: (context, constraints) => AppScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "সাম্প্রতিক সকল বই দেখুন",
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
                    item: item,
                    onSelect: (e) {},
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
}
