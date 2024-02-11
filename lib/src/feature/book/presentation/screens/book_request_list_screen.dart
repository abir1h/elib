import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utility/utility.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/book_request_entity.dart';
import '../services/book_request_list_screen_service.dart';
import 'book_request_bottomsheet_screen.dart';

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
                        onDelete: () => _onDelete(bookRequestId: item.id!),
                        onEdit: () => onTapCreateOrUpdate(
                            bookRequestDataEntity: item, edit: true),
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
              bottom: size.h12,
              right: size.w28,
              child: GestureDetector(
                onTap: () => onTapCreateOrUpdate(
                    bookRequestDataEntity: BookRequestDataEntity(
                        emisUserId: 1,
                        authorName: "",
                        bookName: "",
                        publishYear: "",
                        edition: "",
                        remark: ""),
                    edit: false),
                child: Container(
                  padding: EdgeInsets.all(size.r12),
                  decoration: BoxDecoration(
                    color: clr.cardFillColorMagnolia,
                    borderRadius: BorderRadius.circular(size.r12),
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
                    color: clr.appSecondaryColorPurple,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onDelete({required int bookRequestId}) {
    CustomDialogWidget.show(
            context: context,
            title: "Do you want to delete Request?",
            infoText: "Are you Sure?")
        .then((x) {
      if (x) {
        onBookRequestDelete(bookRequestId);
      }
    });
  }

  void onTapCreateOrUpdate(
      {required BookRequestDataEntity bookRequestDataEntity,
      required bool edit}) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => BookRequestBottomSheet(
              bookRequestDataEntity: bookRequestDataEntity,
              onBookRequestSuccess: () {
                Navigator.of(context).pop();
                loadBookRequestData(false);
              },
              edit: edit,
            ));
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
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const BookRequestItemWidget(
      {super.key,
      required this.bookRequestDataEntity,
      required this.onDelete,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
      decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.r8),
          border: Border(
              top: BorderSide(
                  color: AppUtility.getInstance!
                      .getStatusColor(bookRequestDataEntity.status)!
                      .withOpacity(.64),
                  width: size.h6)),
          boxShadow: [
            BoxShadow(
              color: clr.appPrimaryColorBlack.withOpacity(.2),
              blurRadius: size.r8,
              offset: Offset(0.0, size.h2),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.w8, vertical: size.h4),
                decoration: BoxDecoration(
                  color: AppUtility.getInstance!
                      .getStatusColor(bookRequestDataEntity.status),
                  borderRadius: BorderRadius.circular(size.r24),
                ),
                child: Text(
                  AppUtility.getInstance!
                      .getStatusText(bookRequestDataEntity.status),
                  style: TextStyle(
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w600,
                    fontSize: size.textXXSmall,
                    color: clr.whiteColor,
                  ),
                ),
              ),
              const Spacer(),
              if (bookRequestDataEntity.status == 0)
                GestureDetector(
                  onTap: onEdit,
                  child: SvgPicture.asset(
                    ImageAssets.icEdit,
                    height: size.h24,
                    colorFilter: ColorFilter.mode(
                        clr.appSecondaryColorPurple, BlendMode.srcIn),
                  ),
                ),
              if (bookRequestDataEntity.status == 0)
                Padding(
                  padding: EdgeInsets.only(left: size.w12),
                  child: GestureDetector(
                    onTap: onDelete,
                    child: SvgPicture.asset(
                      ImageAssets.icDelete,
                      height: size.h24,
                      colorFilter: ColorFilter.mode(
                          clr.iconColorSweetRed, BlendMode.srcIn),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: size.h8),
          Text(
            bookRequestDataEntity.bookName,
            style: TextStyle(
              fontFamily: StringData.fontFamilyPoppins,
              fontWeight: FontWeight.w600,
              fontSize: size.textSmall,
              color: clr.appSecondaryColorPurple,
            ),
          ),
          SizedBox(height: size.h12),
          Text(
            "Author: ${bookRequestDataEntity.authorName}",
            style: TextStyle(
              fontFamily: StringData.fontFamilyPoppins,
              fontWeight: FontWeight.w400,
              fontSize: size.textXXSmall,
              color: clr.appPrimaryColorBlack.withOpacity(0.72),
            ),
          ),
          SizedBox(height: size.h4),
          Text(
            "Publish Year: ${bookRequestDataEntity.publishYear}",
            style: TextStyle(
              fontFamily: StringData.fontFamilyPoppins,
              fontWeight: FontWeight.w400,
              fontSize: size.textXXSmall,
              color: clr.appPrimaryColorBlack.withOpacity(0.72),
            ),
          ),
          SizedBox(height: size.h4),
          Text(
            "Edition: ${bookRequestDataEntity.edition}",
            style: TextStyle(
              fontFamily: StringData.fontFamilyPoppins,
              fontWeight: FontWeight.w400,
              fontSize: size.textXXSmall,
              color: clr.appPrimaryColorBlack.withOpacity(0.72),
            ),
          ),
        ],
      ),
    );
  }
}
