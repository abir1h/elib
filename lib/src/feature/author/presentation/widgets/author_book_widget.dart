import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../book/domain/entities/book_data_entity.dart';

class AuthorBookWidget extends StatefulWidget with AppTheme {
  final void Function(BookDataEntity item)? onSelect;
  final void Function(BookDataEntity item)? onBookmarkSelect;
  final BookDataEntity? item;
  final bool? showBookmark;
  final double? aspectRatio;
  const AuthorBookWidget({
    Key? key,
    this.onSelect,
    this.item,
    this.onBookmarkSelect,
    this.showBookmark,
    this.aspectRatio = .8,
  }) : super(key: key);

  @override
  State<AuthorBookWidget> createState() => _AuthorBookWidgetState();
}

class _AuthorBookWidgetState extends State<AuthorBookWidget> with AppTheme {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.r8),
          color: clr.whiteColor,
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
          AspectRatio(
            aspectRatio: widget.aspectRatio!,
            child: Container(
              decoration: BoxDecoration(
                // color: clr.iconColorRed,
                borderRadius: BorderRadius.circular(size.h8),
                border: Border.all(
                  color: clr.appPrimaryColorBlack.withOpacity(.1),
                  width: 1.w,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7.w),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ///Thumbnail image
                    GestureDetector(
                      child: Container(
                        width: double.infinity,
                        // height: double.infinity,
                        color: Colors.grey.withOpacity(0.5),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQqijj5f7q3C0vBN3ruYwiXP_suunlaG_rYyBrMsgH_ZNy44_b9",
                          placeholder: (context, url) => const Offstage(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.image, color: clr.greyColor),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    ///Bookmark
                    widget.showBookmark != null
                        ? Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              /* onTap: widget.onBookmarkSelect != null
                            ? () => widget.onBookmarkSelect!(widget.item)
                            : () {},*/
                              child: Container(
                                  margin: EdgeInsets.all(size.h2),
                                  padding: EdgeInsets.all(size.h2),
                                  decoration: BoxDecoration(
                                    color: clr.whiteColor,
                                    borderRadius:
                                        BorderRadius.circular(size.r4),
                                  ),
                                  child: Icon(
                                    Icons.bookmark,
                                    color: clr.appSecondaryColorPurple,
                                  )
                                  /* widget.item.bookMark
                                ? Icon(
                              Icons.bookmark,
                              color: clr.appSecondaryColorPurple,
                            )
                                : Icon(
                              Icons.bookmark_border_outlined,
                              color: clr.appSecondaryColorPurple,
                            )*/
                                  ),
                            ),
                          )
                        : const Offstage(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: size.h6),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.h8, vertical: size.h8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "The Picture Of Dorian Gray.",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.textXXSmall,
                          fontFamily: StringData.fontFamilyRoboto),
                    ),
                    SizedBox(
                      height: size.h4,
                    ),
                    Text.rich(
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                            text: "by ",
                            style: TextStyle(
                                color: clr.textColorGray,
                                fontSize: size.textXXXSmall,
                                fontWeight: FontWeight.w400,
                                fontFamily: StringData.fontFamilyPoppins),
                            children: [
                              TextSpan(
                                text: "Book Author",
                                style: TextStyle(
                                    color: clr.textColorGray,
                                    fontSize: size.textXXXSmall,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: StringData.fontFamilyPoppins),
                              ),
                            ])),
                  ],
                )),
          ),
          SizedBox(
            height: size.h4,
          )
        ],
      ),
    );
  }
}
