import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({super.key});

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "গ্রন্থকারের তালিকা",
        child: LayoutBuilder(
          builder: (context, constraints) => AuthorSectionWidget(
            items: const ["", "", "", "", "", "", "", "", ""],
            buildItem: (BuildContext context, int index, item) {
              return ItemSectionWidget(
                onTap: () {},
              );
            },
          ),
        ));
  }
}

class AuthorSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const AuthorSectionWidget(
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
        return SizedBox(height: size.h12);
      },
    );
  }
}

class ItemSectionWidget extends StatelessWidget with AppTheme, Language {
  final VoidCallback onTap;
  const ItemSectionWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: clr.cardStrokeColorGrey, width: size.r4)),
            child: CircleAvatar(
              radius: 35.r,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                ImageAssets.imgEmptyProfile,
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
                    "আব্দুল্লাহ আবু সায়ীদ",
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
                    "সকল বই দেখুন",
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
    );
  }
}
