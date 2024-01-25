import 'package:elibrary/src/feature/book/presentation/widgets/book_request_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/book_request_entity.dart';
import '../services/book_request_list_screen_service.dart';

class BookRequestListScreen extends StatefulWidget {
  const BookRequestListScreen({super.key});

  @override
  State<BookRequestListScreen> createState() => _BookRequestListScreenState();
}

class _BookRequestListScreenState extends State<BookRequestListScreen>
    with AppTheme, Language, BookRequestListScreenService {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.bookRequestText, b: bn.bookRequestText),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            AppStreamBuilder<List<BookRequestDataEntity>>(
              stream: bookRequestDataStreamController.stream,
              loadingBuilder: (context) {
                return const Center(child: CircularLoader());
              },
              dataBuilder: (context, data) {
                return BookRequestItemSectionWidget(
                    items: data,
                    buildItem: (context, index, item) {
                      return BookRequestItemWidget(
                        bookRequestDataEntity: item,
                      );
                    });
              },
              emptyBuilder: (context, message, icon) => EmptyWidget(
                message: message,
                constraints: constraints,
                offset: 350.w,
              ),
            ),
            Positioned(
              bottom: size.h10,
              right: size.w10,
              child: GestureDetector(
                onTap: onTapAdd,
                child: Container(
                  padding: EdgeInsets.all(size.r12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: clr.appPrimaryColorGreen,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    size: size.r24,
                    color: clr.whiteColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onTapAdd() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const BookRequestBottomSheet(),
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

class BookRequestItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const BookRequestItemSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h12);
      },
    );
  }
}

class BookRequestItemWidget extends StatelessWidget with AppTheme {
  final BookRequestDataEntity bookRequestDataEntity;
  const BookRequestItemWidget({super.key, required this.bookRequestDataEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
      decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.r8),
          boxShadow: [
            BoxShadow(
              color: clr.blackColor.withOpacity(.2),
              blurRadius: size.r8,
              offset: Offset(0.0, size.h2),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bookRequestDataEntity.bookName,
            style: TextStyle(
              fontFamily: StringData.fontFamilyPoppins,
              fontWeight: FontWeight.w600,
              fontSize: size.textXXSmall,
              color: clr.appPrimaryColorGreen,
            ),
          ),
          SizedBox(height: size.h8),
          Text(
            "Author: ${bookRequestDataEntity.authorName}",
            style: TextStyle(
              fontFamily: StringData.fontFamilyPoppins,
              fontWeight: FontWeight.w500,
              fontSize: size.textXXSmall,
              color: clr.blackColor,
            ),
          ),
          SizedBox(height: size.h2),
          Text(
            "Publish Year: ${bookRequestDataEntity.publishYear}",
            style: TextStyle(
              fontFamily: StringData.fontFamilyPoppins,
              fontWeight: FontWeight.w500,
              fontSize: size.textXXSmall,
              color: clr.blackColor,
            ),
          ),
          SizedBox(height: size.h2),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Edition: ${bookRequestDataEntity.edition}",
                  style: TextStyle(
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                    fontSize: size.textXXSmall,
                    color: clr.blackColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.w4, vertical: size.h4),
                decoration: BoxDecoration(
                  color: clr.appPrimaryColorGreen,
                  borderRadius: BorderRadius.circular(size.r4),
                ),
                child: Text(
                  bookRequestDataEntity.status == 0
                      ? "Inactive"
                      : bookRequestDataEntity.status == 1
                          ? "Active"
                          : bookRequestDataEntity.status == 2
                              ? "Review"
                              : bookRequestDataEntity.status == 3
                                  ? "Hold"
                                  : "Closed",
                  style: TextStyle(
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                    fontSize: size.textXXSmall,
                    color: clr.whiteColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
