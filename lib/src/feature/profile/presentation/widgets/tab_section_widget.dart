import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';

class TabSectionWidget extends StatefulWidget {
  final Widget personalInfo;
  final Widget progressInfo;
  const TabSectionWidget({
    super.key,
    required this.personalInfo,
    required this.progressInfo,
  });

  @override
  State<TabSectionWidget> createState() => _TabSectionWidgetState();
}

class _TabSectionWidgetState extends State<TabSectionWidget>
    with AppTheme, Language, TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.h40),
        TabBar.secondary(
          controller: _tabController,
          labelStyle: TextStyle(
              color: clr.whiteColor,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w600,
              fontFamily: StringData.fontFamilyPoppins),
          unselectedLabelStyle: TextStyle(
              color: clr.textColorBlack,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w500,
              fontFamily: StringData.fontFamilyPoppins),
          indicatorPadding: EdgeInsets.symmetric(horizontal: size.w16),
          indicatorColor: Colors.transparent,
          indicator: BoxDecoration(
              gradient: LinearGradient(colors: [
                clr.profileGradiant2,
                clr.profileGradiant1,
              ]),
              borderRadius: BorderRadius.circular(size.r12),
              border: Border.all(color: clr.appSecondaryColorPurple)),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.r12),
                    border: Border.all(
                        color: clr.appSecondaryColorPurple, width: size.r1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    label(e: en.personalInformation, b: bn.personalInformation),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.r12),
                    border: Border.all(
                        color: clr.appSecondaryColorPurple, width: size.r1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    label(e: en.progressInformation, b: bn.progressInformation),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              widget.personalInfo,
              widget.progressInfo,
            ],
          ),
        ),
      ],
    );
  }
}
