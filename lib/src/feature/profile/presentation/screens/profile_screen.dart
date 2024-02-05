import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/header_widget.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/service/auth_cache_manager.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../service/profile_screen_service.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../domain/entities/profile_data_entity.dart';
import '../../../../core/routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AppTheme, Language, AppEventsNotifier, ProfileScreenService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            HeaderWidget(title: label(e: en.profileText, b: bn.profileText)),
            Expanded(
              child: AppStreamBuilder<ProfileDataEntity>(
                stream: profileDataStreamController.stream,
                loadingBuilder: (context) {
                  return const Center(child: CircularLoader());
                },
                dataBuilder: (context, data) {
                  return Container(
                    color: clr.iconColorWhiteIce,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(height: size.h20),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: clr.cardStrokeColor,
                                            width: size.w1)),
                                    child: CircleAvatar(
                                      radius: 45.r,
                                      backgroundImage: AssetImage(
                                        ImageAssets.imgEmptyProfile,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.h12),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.w16),
                                    child: Text(
                                      label(
                                          e: data.fullnameEn,
                                          b: data.fullnameBn),
                                      // label(
                                      //     e: en.userNameText,
                                      //     b: bn.userNameText),
                                      style: TextStyle(
                                          color: clr.appPrimaryColorBlack,
                                          fontSize: size.textXMedium,
                                          fontWeight: FontWeight.w600,
                                          fontFamily:
                                              StringData.fontFamilyRoboto),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: size.h24)
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: size.w24,
                                    right: size.w16,
                                    top: size.h16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // SvgPicture.asset(ImageAssets.icEdit),
                                    CustomSwitchButton(
                                      value: App.currentAppLanguage ==
                                          AppLanguage.english,
                                      textOn: 'EN',
                                      textSize: size.textXXSmall,
                                      textOff: 'বাং',
                                      bgColor: clr.whiteColor,
                                      width: 64.w,
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      onChanged: (bool state) {
                                        App.setAppLanguage(state ? 1 : 0)
                                            .then((value) {
                                          if (mounted) {
                                            setState(() {});
                                          }
                                          AppEventsNotifier.notify(
                                              EventAction.bottomNavBar);
                                        });
                                      },
                                      buttonHolder: const Icon(
                                        Icons.check,
                                        color: Colors.transparent,
                                      ),
                                      onTap: () {},
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: size.w16),
                            decoration: BoxDecoration(
                                color: clr.scaffoldBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(size.w40),
                                  topRight: Radius.circular(size.w40),
                                ),
                                border: Border(
                                    top: BorderSide(color: clr.cardStrokeColor),
                                    right: BorderSide(
                                        color: clr.cardStrokeColor))),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(height: size.h40),
                                  TitleWithIcon(
                                    icon: Icons.account_balance,
                                    // title: label(
                                    //     e: data.fullnameEn, b: data.fullnameBn),
                                    title: label(
                                        e: en.currentOrganizationNameText,
                                        b: bn.currentOrganizationNameText),
                                  ),
                                  TitleWithIcon(
                                      icon: Icons.beenhere,
                                      // title: label(
                                      //     e: data.fullnameEn, b: data.fullnameEn),
                                      title: label(
                                          e: en.positionNameText,
                                          b: bn.positionNameText)),
                                  TitleWithIcon(
                                    icon: Icons.badge,
                                    title: data.empId,
                                    // title:
                                    //     label(e: en.regNoText, b: bn.regNoText),
                                  ),
                                  TitleWithIcon(
                                    icon: Icons.phone,
                                    title: data.mobileNo,
                                    // title: label(
                                    //     e: en.phoneNumberText,
                                    //     b: bn.phoneNumberText),
                                  ),
                                  TitleWithIcon(
                                    onTap: () {},
                                    icon: Icons.email,
                                    title: data.email,
                                  ),
                                  TitleWithIcon(
                                    onTap: onTapNotes,
                                    icon: Icons.event_note_sharp,
                                    title: label(e: "Notes", b: "Notes"),
                                  ),
                                  TitleWithIcon(
                                    icon: Icons.logout,
                                    title: label(
                                        e: en.logoutText, b: bn.logoutText),
                                    onTap: showLogoutPromptDialog,
                                    hasBorder: false,
                                  ),
                                  SizedBox(height: size.h64),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                emptyBuilder: (context, message, icon) => EmptyWidget(
                  message: message,
                  constraints: constraints,
                  offset: 350.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutPromptDialog() {
    CustomDialogWidget.show(
      context: context,
      title: label(e: en.logoutWarningText, b: bn.logoutWarningText),
      infoText: label(
          e: "Your ID login is required for your courses and assessment news.",
          b: "আপনার কোর্সগুলো এবং মূল্যায়নের খবরের জন্য আপনার আইডি লগইন থাকা প্রয়োজন।"),
      rightButtonText: label(e: en.cancelText, b: bn.cancelText),
      leftButtonText: label(e: en.exitText, b: bn.exitText),
    ).then((value) {
      if (value) {
        AuthCacheManager.userLogout();
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoute.authenticationScreen, (x) => false);
      }
    });
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.bottomNavAllScreen ||
        action == EventAction.profileScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void navigateToNotesScreen() {
    Navigator.of(context).pushNamed(AppRoute.noteScreen);
  }
}

class TitleWithIcon extends StatelessWidget with AppTheme {
  final IconData? icon;
  final String? svgIcon;
  final String title;
  final bool hasBorder;
  final bool hasTrailing;
  final VoidCallback? onTap;
  const TitleWithIcon(
      {super.key,
      this.icon,
      this.svgIcon,
      required this.title,
      this.hasBorder = true,
      this.hasTrailing = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
            left: size.w4, top: size.h16, bottom: size.h16, right: size.w12),
        decoration: BoxDecoration(
          border: hasBorder
              ? Border(
                  bottom: BorderSide(color: clr.boxStrokeColor),
                )
              : null,
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                color: clr.appPrimaryColorBlack,
                size: size.r20,
              ),
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon!,
                colorFilter:
                    ColorFilter.mode(clr.appPrimaryColorBlack, BlendMode.srcIn),
                // color: clr.hintIconColor,
              ),
            SizedBox(width: size.w16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    color: clr.iconColorHint,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
            if (hasTrailing)
              Icon(
                Icons.arrow_circle_right,
                color: clr.appPrimaryColorBlack,
                size: size.r16,
              ),
          ],
        ),
      ),
    );
  }
}
