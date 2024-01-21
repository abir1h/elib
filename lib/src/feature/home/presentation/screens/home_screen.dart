
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_scroll_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/paginated_gridview_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/toasty.dart';
import '../services/home_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> with AppTheme,HomeScreenService {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.h20),
      child: LayoutBuilder(
        builder:(context, constraints)=> AppScrollView(
          padding: EdgeInsets.only(bottom: size.h64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
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
                        SizedBox(height: size.h8,),
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
                    child: Image.asset(
                      AppAssets.imgELibraryHeader,
                      fit: BoxFit.contain,
                    ),
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
              ///Content section
              AppStreamBuilder<PaginatedGridViewController<ELibraryEntity>>(
                stream: eLibraryDataStreamController.stream,
                loadingBuilder: (x)=>SectionLoadingWidget(
                  constraints: constraints,
                  offset: 350.w,
                ),
                dataBuilder: (context, data){
                  ///Item widget
                  return PaginatedGridView<ELibraryEntity>(
                    controller: paginationController,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: size.s12,
                      mainAxisSpacing: size.s12,
                    ),
                    itemBuilder: (context, item, index) {
                      return ELibContentItemWidget(
                        key: Key(item.id.toString()),
                        item: item,
                        onSelect: onELibraryContentSelected,
                      );
                    },
                    loaderBuilder: (context)=> Padding(
                      padding: EdgeInsets.all(4.0.w),
                      child: Center(
                        child: CircularLoader(loaderSize: 16.w,),
                      ),
                    ),
                  );
                },
                emptyBuilder: (context, message,icon){
                  return SectionEmptyWidget(
                    constraints: constraints,
                    message: message,
                    icon: icon,
                    offset: 350.w,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}


class ItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final Stream<DataState<ResultsForViewModel>> stream;
  const ItemSectionWidget({Key? key, required this.stream,}) : super(key: key);

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
            initialData: DataLoadedState<ResultsForViewModel>(ResultsForViewModel.newUploads()),
            builder: (context, snapshot){
              var data = (snapshot.data! as DataLoadedState<ResultsForViewModel>).data;
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
                  SizedBox(height: 2.w,),
                  if(data.subTitle.isNotEmpty)Text(
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
class ELibContentItemWidget extends StatefulWidget with AppTheme{
  final void Function(Book item) onSelect;
  final ELibraryEntity item;
  const ELibContentItemWidget({Key? key,required this.onSelect,required this.item}) : super(key: key);

  @override
  State<ELibContentItemWidget> createState() => _ELibContentItemWidgetState();
}
class _ELibContentItemWidgetState extends State<ELibContentItemWidget> with AppTheme, AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: ()=> widget.onSelect(widget.item),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.h8),
          border: Border.all(
            color: clr.appPrimaryColorGreen.withOpacity(.1),
            width: 1.w,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.w),
          child: Stack(
            children: [
              ///Thumbnail image
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey.withOpacity(0.5),
                child: CachedNetworkImage(
                  imageUrl: AppConstant.getCourseThumbnailUrl(widget.item.imagePath),
                  fit: BoxFit.cover,
                ),
              ),

              ///Content title
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.maxFinite,
                  color: Colors.black.withOpacity(0.7),
                  padding: EdgeInsets.all(size.h8,

                  ),
                  child: Text(
                    widget.item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: clr.whiteColor,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              ///Content Type icon
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.all(size.h4),
                  padding: EdgeInsets.all(size.h4),
                  decoration: BoxDecoration(
                    color: clr.appPrimaryColorGreen.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(size.h4,),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        getIconImageByType(widget.item.materialType),
                        height: size.h12,
                        width: size.h12,
                        color: Colors.white,
                      ),
                      SizedBox(width: size.h4,),
                      Text(
                        widget.item.materialType,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: clr.whiteColor,
                          fontSize: size.textXXSmall,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
