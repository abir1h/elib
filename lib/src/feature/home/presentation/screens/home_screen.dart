import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../services/home_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AppTheme, HomeScreenService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.h20),
        child: LayoutBuilder(
          builder: (context, constraints) => AppScrollView(
            padding: EdgeInsets.only(bottom: size.h64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Header text and image
                Row(
                  children: [
                    ///Header text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CLMS E-Library',
                            style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textXLarge,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: size.h8,
                          ),
                          Text(
                            'Enriching life with knowledge of the world',
                            style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontWeight: FontWeight.w200,
                              fontSize: size.textSmall,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///Header Image
                    SizedBox(
                      width: size.h64 * 2,
                      height: size.h64 * 2,
                      // child: Image.asset("",
                      //   fit: BoxFit.contain,
                      // ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.h12,
                ),

                ///Search Box and Bookmark button
                // Row(
                //   children: [
                //     Expanded(
                //       child: SearchBoxWidget(
                //         hintText: "Search..",
                //         onSearchTermChange: onSearchTermChanged,
                //         serviceState: serviceState,
                //       ),
                //     ),
                //   ],
                // ),

                ///Content section
                AppStreamBuilder<List<BookDataEntity>>(
                  stream: bookDataStreamController.stream,
                  loadingBuilder: (context) {
                    return const Center(child: CircularLoader());
                  },
                  dataBuilder: (context, data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Popular Books",
                          style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: size.h12,
                        ),
                        GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: .6,
                            crossAxisSpacing: size.h12,
                            mainAxisSpacing: size.h12,
                          ),
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ELibContentItemWidget(
                              key: Key(data[index].id.toString()),
                              item: data[index],
                              onSelect: onBookContentSelected,
                              onBookmarkSelect: onBookmarkContentSelected,
                            );
                          },
                        ),
                      ],
                    );

                    // return  Expanded(
                    //   child: Container(
                    //     color: Colors.deepOrange,
                    // child: GridView.builder(
                    //           physics: const BouncingScrollPhysics(),
                    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //             crossAxisCount: 2,
                    //             childAspectRatio: 0.7,
                    //             crossAxisSpacing: size.h12,
                    //             mainAxisSpacing: size.h12,
                    //           ),
                    //           itemCount: data.length,
                    //           shrinkWrap: false,
                    //           itemBuilder: (context, index) {
                    //             return Container();
                    //           },
                    //         ),
                    // )
                    // );
                    ///Item widget
                    // return Column(
                    //   children: [
                    //     Expanded(
                    //         child: GridView.builder(
                    //           physics: const BouncingScrollPhysics(),
                    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //             crossAxisCount: 2,
                    //             childAspectRatio: 0.7,
                    //             crossAxisSpacing: size.h12,
                    //             mainAxisSpacing: size.h12,
                    //           ),
                    //           itemCount: data.length,
                    //           shrinkWrap: false,
                    //           itemBuilder: (context, index) {
                    //             return Container();
                    //           },
                    //         ))
                    //   ],
                    // );
                  },
                  emptyBuilder: (context, message, icon) {
                    return Container(
                      child: Text("Tushar"),
                    );
                  },
                ),

                ///Search Box and Bookmark button
                // Row(
                //   children: [
                //     Expanded(
                //       child: SearchBoxWidget(
                //         hintText: "Search..",
                //         onSearchTermChange: onSearchTermChanged,
                //         serviceState: serviceState,
                //       ),
                //     ),
                //     CategoryFilterMenu(
                //       serviceState: serviceState,
                //       onLoadData: onLoadCategoryList,
                //       onCategorySelected: onCategorySelected,
                //     ),
                //   ],
                // ),

                // ///Results for text
                // ItemSectionWidget(
                //   stream: resultsForStreamController.stream,
                // ),
                // ///Content section
                // AppStreamBuilder<PaginatedGridViewController<BookDataEntity>>(
                //   stream: eLibraryDataStreamController.stream,
                //   loadingBuilder: (x)=>
                //
                //       CircularProgressIndicator(),
                //   //     SectionLoadingWidget(
                //   //   constraints: constraints,
                //   //   offset: 350.w,
                //   // ),
                //   dataBuilder: (context, data){
                //     ///Item widget
                //     return PaginatedGridView<PaginatedGridViewController<BookDataEntity>>(
                //       controller: paginationController,
                //       physics: const BouncingScrollPhysics(),
                //       shrinkWrap: true,
                //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 2,
                //         childAspectRatio: 0.7,
                //         crossAxisSpacing: size.h12,
                //         mainAxisSpacing: size.h12,
                //       ),
                //       itemBuilder: (context, item, index) {
                //         return Container();
                //
                //         //   ELibContentItemWidget(
                //         //   // key: Key(item.id.toString()),
                //         //   item: item,
                //         //   onSelect: onELibraryContentSelected,
                //         // );
                //       },
                //       loaderBuilder: (context)=> Padding(
                //         padding: EdgeInsets.all(4.0.w),
                //         child: Center(
                //           child: CircularProgressIndicator(),
                //         ),
                //       ),
                //     );
                //   },
                //   emptyBuilder: (context, message,icon){
                //     return CircularProgressIndicator();
                //
                //     //   SectionEmptyWidget(
                //     //   constraints: constraints,
                //     //   message: message,
                //     //   icon: icon,
                //     //   offset: 350.w,
                //     // );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }

  @override
  void navigateToBookDetailsScreen(BookDataEntity data) {
    Navigator.of(context).pushNamed(
      AppRoute.bookDetailsScreen,
      arguments: BookDetailsScreenArgs(bookData: data),
    );
  }
}

class ItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final Stream<DataState<ResultsForViewModel>> stream;
  const ItemSectionWidget({
    Key? key,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Header text
        Padding(
          padding: EdgeInsets.only(
            top: size.h32,
            bottom: size.h8,
          ),
          child: StreamBuilder<DataState<ResultsForViewModel>>(
            stream: stream,
            initialData: DataLoadedState<ResultsForViewModel>(
                ResultsForViewModel.newUploads()),
            builder: (context, snapshot) {
              var data =
                  (snapshot.data! as DataLoadedState<ResultsForViewModel>).data;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                      color: clr.textColorBlack,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  if (data.subTitle.isNotEmpty)
                    Text(
                      data.subTitle,
                      style: TextStyle(
                        color: clr.textColorBlack,
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: size.h4),
      ],
    );
  }
}

class ELibContentItemWidget extends StatefulWidget with AppTheme {
  final void Function(BookDataEntity item) onSelect;
  final void Function(BookDataEntity item)? onBookmarkSelect;
  final BookDataEntity item;
  const ELibContentItemWidget(
      {Key? key,
      required this.onSelect,
      required this.item,
      this.onBookmarkSelect})
      : super(key: key);

  @override
  State<ELibContentItemWidget> createState() => _ELibContentItemWidgetState();
}

class _ELibContentItemWidgetState extends State<ELibContentItemWidget>
    with AppTheme, AutomaticKeepAliveClientMixin {
  StreamController<bool> controller = StreamController();

  @override
  void initState() {
    controller.stream.listen((event) {
      print(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
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
                        imageUrl:
                            "http://103.209.40.89:82/uploads/${widget.item.coverImage}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  ///Bookmark
                  Align(
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
                            borderRadius: BorderRadius.circular(size.r4),
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
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: size.h4),
        GestureDetector(
          onTap: () => widget.onSelect(widget.item),
          child: Text(
            widget.item.titleEn,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: clr.appPrimaryColorGreen,
              fontSize: size.textXXSmall,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text.rich(
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            TextSpan(
                text: widget.item.author.isNotEmpty ? "by " : "",
                style: TextStyle(
                    color: clr.placeHolderTextColorGray,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                    text: widget.item.author
                        .map((c) => c.name)
                        .toList()
                        .join(', '),
                    style: TextStyle(
                        color: clr.textColorAppleBlack,
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w600),
                  ),
                ])),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
