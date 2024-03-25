import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_theme.dart';

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
        crossAxisSpacing: size.h12,
        mainAxisSpacing: size.h12,
        mainAxisExtent: .29.sh,
      ),
      itemCount: items.length,
      shrinkWrap: true,
      // padding: EdgeInsets.symmetric(vertical: size.h20),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
    );
  }
}
