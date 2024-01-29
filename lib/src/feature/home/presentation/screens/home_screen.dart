import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/search_book_widget.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/presentation/widgets/elib_content_item_widget.dart';
import '../services/home_service.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AppTheme, Language, HomeScreenService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            AppScrollView(
              padding: EdgeInsets.only(bottom: size.h64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.h42),

                  ///Header text and image
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w20),
                    child: Row(
                      children: [
                        ///Header text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label(e: en.appBarText, b: bn.appBarText),
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textXLarge,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: size.h8),
                              Text(
                                label(
                                    e: en.homeHeaderText, b: bn.homeHeaderText),
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
                          child: Image.asset(
                            ImageAssets.imageHome,
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.h12),

                  ///Search Box and Bookmark button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w20),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchBoxWidget(
                            hintText: label(e: en.searchText, b: bn.searchText),
                            onSearchTermChange: onSearchTermChanged,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Results for text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w20),
                    child: ItemSectionWidget(
                      stream: resultsForStreamController.stream,
                    ),
                  ),

                  ///Content section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.h12),
                    child: AppStreamBuilder<List<BookDataEntity>>(
                      stream: bookDataStreamController.stream,
                      loadingBuilder: (context) {
                        return ShimmerLoader(
                            child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: .5,
                            crossAxisSpacing: size.h12,
                            mainAxisSpacing: size.h12,
                          ),
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ELibContentItemWidget(
                              item: BookDataEntity(
                                  id: -1,
                                  titleEn: "",
                                  titleBn: "",
                                  languageEn: "",
                                  languageBn: "",
                                  editionEn: "",
                                  editionBn: "",
                                  publishYearEn: "",
                                  publishYearBn: "",
                                  publisherEn: "",
                                  publisherBn: "",
                                  isbnEn: "",
                                  isbnBn: "",
                                  slug: "",
                                  descriptionEn: "",
                                  descriptionBn: "",
                                  coverImage: "",
                                  bookFile: "",
                                  externalLink: "",
                                  createdBy: -1,
                                  isDownload: -1,
                                  status: -1,
                                  bookMark: false,
                                  createdAt: "",
                                  updatedAt: "",
                                  deletedAt: "",
                                  author: [],
                                  category: []),
                              onSelect: (e) {},
                              onBookmarkSelect: (e) {},
                            );
                          },
                        ));
                      },
                      dataBuilder: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.h12,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: size.h8),
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: .5,
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
                                    showBookmark: true,
                                    onBookmarkSelect: onBookmarkContentSelected,
                                    boxShadow: true,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      emptyBuilder: (context, message, icon) {
                        return EmptyWidget(
                          constraints: constraints,
                          message: message,
                          icon: icon,
                          offset: 350.w,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: size.w20,
              top: size.h10,
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  padding: EdgeInsets.all(size.r6),
                  decoration: BoxDecoration(
                    color: clr.whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: clr.blackColor.withOpacity(.2),
                        blurRadius: size.r8,
                        offset: Offset(0.0, size.h2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.menu,
                    size: size.r24,
                    color: clr.appPrimaryColorGreen,
                  ),
                ),
              ),
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
  void navigateToBookDetailsScreen(BookDataEntity data) {
    Navigator.of(context).pushNamed(
      AppRoute.bookDetailsScreen,
      arguments: BookDetailsScreenArgs(bookData: data),
    );
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
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
                        color: clr.appPrimaryColorGreen,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w600),
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
