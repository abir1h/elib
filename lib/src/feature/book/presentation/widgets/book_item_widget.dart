import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/book_data_entity.dart';
import '../services/book_widget_services.dart';

/*class ELibContentItemWidget extends StatefulWidget with AppTheme {
  final void Function(BookDataEntity item) onSelect;
  final void Function(BookDataEntity item)? onBookmarkSelect;
  final BookDataEntity item;
  final bool boxShadow;
  final bool showBookmark;
  final double aspectRatio;
  const ELibContentItemWidget({
    Key? key,
    required this.onSelect,
    required this.item,
    this.onBookmarkSelect,
    this.showBookmark = true,
    this.boxShadow = false,
    this.aspectRatio = .8,
  }) : super(key: key);

  @override
  State<ELibContentItemWidget> createState() => _ELibContentItemWidgetState();
}

class _ELibContentItemWidgetState extends State<ELibContentItemWidget>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.boxShadow
          ? BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(size.r4),
                  topLeft: Radius.circular(size.r4)),
              color: clr.whiteColor,
              // boxShadow: [
              //   BoxShadow(
              //     color: clr.appPrimaryColorBlack.withOpacity(.2),
              //     blurRadius: size.r8,
              //     offset: Offset(0.0, size.h2),
              //   ),
              // ],
            )
          : const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Container(
              decoration: BoxDecoration(
                  // color: clr.iconColorRed,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(size.r4),
                      topLeft: Radius.circular(size.r4)),
                  border: Border.all(
                    color: clr.appPrimaryColorBlack.withOpacity(.1),
                    width: 1.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: clr.appPrimaryColorBlack.withOpacity(.2),
                      blurRadius: size.r8,
                      offset: Offset(0.0, size.h2),
                    ),
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size.r4),
                    topLeft: Radius.circular(size.r4)),
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
                          fit: BoxFit.fill,
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
                                          color: clr.appSecondaryColorPurple,
                                        )
                                      : Icon(
                                          Icons.bookmark_border_outlined,
                                          color: clr.appSecondaryColorPurple,
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
              child: Text.rich(
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                      text: widget.item.author!.isNotEmpty ? "লেখক " : "",
                      style: TextStyle(
                          color: clr.textColorGray,
                          fontSize: size.textXXXSmall,
                          fontWeight: FontWeight.w400,
                          fontFamily: StringData.fontFamilyPoppins),
                      children: [
                        TextSpan(
                          text: widget.item.author!
                              .map((c) => c.name)
                              .toList()
                              .join(', '),
                          style: TextStyle(
                              color: clr.textColorGray,
                              fontSize: size.textXXXSmall,
                              fontWeight: FontWeight.w400,
                              fontFamily: StringData.fontFamilyPoppins),
                        ),
                      ])),
            ),
          ),
          SizedBox(height: size.h4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.h4),
            child: GestureDetector(
              onTap: () => widget.onSelect(widget.item),
              child: Text(
                widget.item.titleEn,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: clr.appPrimaryColorBlack,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
          ),
          SizedBox(
            height: size.h4,
          )
        ],
      ),
    );
  }
}*/

class BookItemWidget extends StatefulWidget {
  final void Function(BookDataEntity item) onSelect;
  final void Function(BookDataEntity item)? onBookmarkSelect;
  final BookDataEntity item;
  final bool showBookmark;
  const BookItemWidget({
    super.key,
    required this.onSelect,
    this.onBookmarkSelect,
    required this.item,
    this.showBookmark = true,
  });

  @override
  State<BookItemWidget> createState() => _BookItemWidgetState();
}

class _BookItemWidgetState extends State<BookItemWidget> with AppTheme,BookmarkWidgetService{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSelect(widget.item),
      child: Container(
        color: clr.whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: .75,
                  child: Container(
                    // height: 0.2.sh,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size.r4),
                          topLeft: Radius.circular(size.r4)),
                      boxShadow: [
                        BoxShadow(
                          color: clr.appPrimaryColorBlack.withOpacity(.2),
                          blurRadius: size.r8,
                          offset: Offset(0.0, size.h2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size.r4),
                          topLeft: Radius.circular(size.r4)),
                      child: CachedNetworkImage(
                        imageUrl: widget.item.coverImage.isNotEmpty
                            ? "http://103.209.40.89:82/uploads/${widget.item.coverImage}"
                            : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQNL_ZnOTpXSvhf1UaK7beHey2BX42U6solRA&usqp=CAU",
                        placeholder: (context, url) =>
                            Icon(Icons.image, color: clr.greyColor),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.image, color: clr.greyColor),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                // StreamBuilder(
                //   stream: bookMarkIconController.stream,
                //   initialData:widget.showBookmark,
                //   builder: (context, snapshot) {
                //     return   Align(
                //         alignment: Alignment.topRight,
                //         child: GestureDetector(
                //           onTap:()=> onBookmarkContentSelected(widget.item),
                //           child: Container(
                //               margin: EdgeInsets.only(top: size.h4, right: size.w4),
                //               padding: EdgeInsets.all(size.h2),
                //               decoration: BoxDecoration(
                //                 color: clr.whiteColor,
                //                 borderRadius: BorderRadius.circular(size.r4),
                //               ),
                //               child: snapshot.data!
                //                   ? Icon(
                //                       Icons.bookmark,
                //                       color: clr.appSecondaryColorPurple,
                //                     )
                //                   : Icon(
                //                       Icons.bookmark_border_outlined,
                //                       color: clr.appSecondaryColorPurple,
                //                     )),
                //         ),
                //       );
                //   },
                // )
                if (widget.showBookmark)
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap:()=> onBookmarkContentSelected(widget.item),
                      child: Container(
                          margin: EdgeInsets.only(top: size.h4, right: size.w4),
                          padding: EdgeInsets.all(size.h2),
                          decoration: BoxDecoration(
                            color: clr.whiteColor,
                            borderRadius: BorderRadius.circular(size.r4),
                          ),
                          child:  StreamBuilder(
                            stream: bookMarkIconController.stream,
                            initialData: widget.item.bookMark,
                            builder: (context, snapshot) {
                              widget.item.bookMark=snapshot.data!;
                              return  snapshot.data!
                                  ? Icon(
                                Icons.bookmark,
                                color: clr.appSecondaryColorPurple,
                              )
                                  : Icon(
                                Icons.bookmark_border_outlined,
                                color: clr.appSecondaryColorPurple,
                              );
                            },
                          )


                          // widget.item.bookMark
                          //     ? Icon(
                          //         Icons.bookmark,
                          //         color: clr.appSecondaryColorPurple,
                          //       )
                          //     : Icon(
                          //         Icons.bookmark_border_outlined,
                          //         color: clr.appSecondaryColorPurple,
                          //       )),
                    ),
                  ),
                // ///Bookmark
                // if (widget.showBookmark)
                //   Align(
                //     alignment: Alignment.topRight,
                //     child: GestureDetector(
                //       onTap: widget.onBookmarkSelect != null
                //           ? () =>widget. onBookmarkSelect!(widget.item)
                //           : () {},
                //       child: Container(
                //           margin: EdgeInsets.only(top: size.h4, right: size.w4),
                //           padding: EdgeInsets.all(size.h2),
                //           decoration: BoxDecoration(
                //             color: clr.whiteColor,
                //             borderRadius: BorderRadius.circular(size.r4),
                //           ),
                //           child: widget.item.bookMark
                //               ? Icon(
                //                   Icons.bookmark,
                //                   color: clr.appSecondaryColorPurple,
                //                 )
                //               : Icon(
                //                   Icons.bookmark_border_outlined,
                //                   color: clr.appSecondaryColorPurple,
                //                 )),
                //     ),
                  ),
              ],
            ),
            SizedBox(height: size.h8),
            if (widget.item.author!.isNotEmpty)
              Text.rich(
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: clr.textColorMamba,
                      fontSize: size.textXXSmall,
                      fontWeight: FontWeight.w400,
                      fontFamily: StringData.fontFamilyPoppins),
                  TextSpan(
                      text: widget.item.author!.isNotEmpty ? "লেখক " : "",
                      children: [
                        TextSpan(
                          text: widget.item.author!
                              .map((c) => c.name)
                              .toList()
                              .join(', '),
                        ),
                      ])),
            SizedBox(height: size.h4),
            Text(
              widget.item.titleEn,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: clr.textColorGray27,
                  fontSize: size.textXXSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }

  @override
  void showSuccess(String message) {
    // TODO: implement showSuccess
  }
}
