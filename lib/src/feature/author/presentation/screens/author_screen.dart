import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/author_data_entity.dart';
import '../services/author_service.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({super.key});

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen>
    with AppTheme, Language, AuthorService {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "গ্রন্থকারের তালিকা",
        child: LayoutBuilder(
          builder: (context, constraints) =>
              AppStreamBuilder<List<AuthorDataEntity>>(
            stream: authorDataStreamController.stream,
            loadingBuilder: (context) {
              return ShimmerLoader(
                  child: AuthorItemSectionWidget(
                      items: const [
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    ""
                  ],
                      buildItem: (BuildContext context, int index, item) {
                        return AuthorItemWidget(
                          authorDataEntity: const AuthorDataEntity(
                            id: -1,
                            authorTypeId: -1,
                            name: "",
                            slug: "",
                            email: "",
                            phone: "",
                            address: "",
                            country: "",
                            photo: "",
                            status: -1,
                            createdAt: "",
                            updatedAt: "",
                            deletedAt: "",
                          ),
                          onTap: () {},
                        );
                      }));
            },
            dataBuilder: (context, data) {
              return AuthorItemSectionWidget(
                  items: data,
                  buildItem: (BuildContext context, int index, item) {
                    return AuthorItemWidget(
                      authorDataEntity: item,
                      onTap: () => onTapAuthor(item),
                    );
                  });
            },
            emptyBuilder: (context, message, icon) => EmptyWidget(
              message: message,
              constraints: constraints,
              offset: 350.w,
            ),
          ),
        ));
  }

  @override
  void navigateToAuthorBooksScreen(AuthorDataEntity authorDataEntity) {
    Navigator.of(context).pushNamed(AppRoute.authorBooksScreen,
        arguments: AuthorBookScreenArgs(authorDataEntity: authorDataEntity));
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

class AuthorItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const AuthorItemSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h20),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h20);
      },
    );
  }
}

class AuthorItemWidget extends StatelessWidget with AppTheme, Language {
  final AuthorDataEntity authorDataEntity;
  final String subTitle;
  final VoidCallback onTap;

  const AuthorItemWidget({
    super.key,
    required this.authorDataEntity,
    this.subTitle = "সকল বই দেখুন",
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w24, vertical: size.h12),
        decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.r12),
          border: Border(
              left: BorderSide(
                  color: clr.cardStrokeColorCylindricalCoordinate,
                  width: size.w4)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: clr.cardStrokeColorGrey, width: size.r4)),
              child: CircleAvatar(
                radius: 24.r,
                backgroundColor: Colors.transparent,
                child: CachedNetworkImage(
                  imageUrl: authorDataEntity.photo.isNotEmpty
                      ? "http://103.209.40.89:82/uploads/${authorDataEntity.photo}"
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQNL_ZnOTpXSvhf1UaK7beHey2BX42U6solRA&usqp=CAU",
                  placeholder: (context, url) => const Offstage(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.image, color: clr.greyColor),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: size.w12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      authorDataEntity.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: clr.textColorBlack,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w600,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                    SizedBox(height: size.h8),
                    Text(
                      subTitle,
                      style: TextStyle(
                          color: clr.textColorBlack,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
