import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';

class TabSwitchWidget extends StatefulWidget {
  final void Function(int)? onTabChange;
  const TabSwitchWidget({Key? key, this.onTabChange}) : super(key: key);

  @override
  State<TabSwitchWidget> createState() => _TabSwitchWidgetState();
}

class _TabSwitchWidgetState extends State<TabSwitchWidget>
    with AppTheme, Language, SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _shaderAlignAnimation;
  late Animation<Color?> _firstTabAnimation;
  late Animation<Color?> _secondTabAnimation;
  int _selectedTabIndex = 0;
  final int _animDuration = 100;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _animDuration));
    _shaderAlignAnimation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(_animationController);
    _firstTabAnimation =
        ColorTween(begin: clr.whiteColor, end: clr.appPrimaryColorBlack)
            .animate(_animationController);
    _secondTabAnimation =
        ColorTween(begin: clr.appPrimaryColorBlack, end: clr.whiteColor)
            .animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.r12),
      child: Container(
        width: double.maxFinite,
        height: size.h42,
        decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.r12),
        ),
        child: LayoutBuilder(builder: (context, sizeConstraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Align(
                    alignment: _shaderAlignAnimation.value,
                    child: child,
                  );
                },
                child: Container(
                  height: sizeConstraints.maxHeight,
                  width: sizeConstraints.maxWidth / 2.1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      clr.profileGradiant2,
                      clr.profileGradiant1,
                    ]),
                    borderRadius: BorderRadius.circular(size.r12),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onTabChange(0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.w16, vertical: size.h8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.r12),
                            border: Border.all(
                                color: clr.tabStrokeColor.withOpacity(0.5),
                                width: size.r1)),
                        child: Center(
                          child: AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Text(
                                  label(
                                      e: en.personalInformation,
                                      b: bn.personalInformation),
                                  style: TextStyle(
                                    color: _firstTabAnimation.value,
                                    fontWeight: _selectedTabIndex == 0
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    fontSize: size.textSmall,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.w16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onTabChange(1),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.w16, vertical: size.h8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.r12),
                            border: Border.all(
                                color: clr.tabStrokeColor.withOpacity(0.5),
                                width: size.r1)),
                        child: Center(
                          child: AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Text(
                                  label(
                                      e: en.progressInformation,
                                      b: bn.progressInformation),
                                  style: TextStyle(
                                    color: _secondTabAnimation.value,
                                    fontWeight: _selectedTabIndex == 1
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    fontSize: size.textSmall,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  _onTabChange(int index) {
    if (mounted && index != _selectedTabIndex) {
      _selectedTabIndex = index;
      if (_selectedTabIndex == 0) {
        _animationController.reverse().whenComplete(() {
          widget.onTabChange?.call(_selectedTabIndex);
        });
      } else {
        _animationController.forward().whenComplete(() {
          widget.onTabChange?.call(_selectedTabIndex);
        });
      }
    }
  }
}
