import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/book_data_entity.dart';

class ELibContentItemWidget extends StatefulWidget with AppTheme {
  final void Function(BookDataEntity item) onSelect;
  final void Function(BookDataEntity item)? onBookmarkSelect;
  final BookDataEntity item;
  final bool boxShadow;
  final bool? showBookmark;
  final double aspectRatio;
  const ELibContentItemWidget({
    Key? key,
    required this.onSelect,
    required this.item,
    this.onBookmarkSelect,
    this.showBookmark,
    this.boxShadow = false,
    this.aspectRatio = .8,
  }) : super(key: key);

  @override
  State<ELibContentItemWidget> createState() => _ELibContentItemWidgetState();
}

class _ELibContentItemWidgetState extends State<ELibContentItemWidget>
    with AppTheme {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.boxShadow
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(size.r8),
              color: clr.cardFillColorBlue,
              boxShadow: [
                  BoxShadow(
                    color: clr.blackColor.withOpacity(.2),
                    blurRadius: size.r8,
                    offset: Offset(0.0, size.h2),
                  ),
                ])
          : const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Container(
              decoration: BoxDecoration(
                // color: clr.iconColorRed,
                borderRadius: BorderRadius.circular(size.h8),
                border: Border.all(
                  color: clr.appPrimaryColorGreen.withOpacity(.1),
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
                      onTap: () => widget.onSelect(widget.item),
                      child: Container(
                        width: double.infinity,
                        // height: double.infinity,
                        color: Colors.grey.withOpacity(0.5),
                        child: CachedNetworkImage(
                          imageUrl: widget.item.coverImage.isNotEmpty
                              ? "http://103.209.40.89:82/uploads/${widget.item.coverImage}"
                              : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQNL_ZnOTpXSvhf1UaK7beHey2BX42U6solRA&usqp=CAU",
                          placeholder: (context, url) => const Offstage(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.image, color: clr.greyColor),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    ///Bookmark
                    widget.showBookmark != null
                        ? Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: widget.onBookmarkSelect != null
                                  ? () => widget.onBookmarkSelect!(widget.item)
                                  : () {},
                              child: Container(
                                  margin: EdgeInsets.all(size.h2),
                                  padding: EdgeInsets.all(size.h2),
                                  decoration: BoxDecoration(
                                    color: clr.whiteColor,
                                    borderRadius:
                                        BorderRadius.circular(size.r4),
                                  ),
                                  child: widget.item.bookMark
                                      ? Icon(
                                          Icons.bookmark,
                                          color: clr.appPrimaryColorGreen,
                                        )
                                      : Icon(
                                          Icons.bookmark_border_outlined,
                                          color: clr.appPrimaryColorGreen,
                                        )),
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
              padding: EdgeInsets.symmetric(horizontal: size.h4),
              child: GestureDetector(
                onTap: () => widget.onSelect(widget.item),
                child: Text(
                  widget.item.titleEn,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.h4),
            child: Text.rich(
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                TextSpan(
                    text: widget.item.author.isNotEmpty ? "by " : "",
                    style: TextStyle(
                        color: clr.appPrimaryColorGreen,
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: widget.item.author
                            .map((c) => c.name)
                            .toList()
                            .join(', '),
                        style: TextStyle(
                            color: clr.textColorBlack,
                            fontSize: size.textXXSmall,
                            fontWeight: FontWeight.w600),
                      ),
                    ])),
          ),
          SizedBox(
            height: size.h4,
          )
        ],
      ),
    );
  }
}
