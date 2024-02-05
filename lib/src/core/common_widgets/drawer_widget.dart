import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/language.dart';
import '../routes/app_routes.dart';
import '../service/auth_cache_manager.dart';
import '../service/notifier/app_events_notifier.dart';
import 'custom_dialog_widget.dart';
import 'custom_switch_button.dart';
import '../utility/app_label.dart';
import '../constants/common_imports.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: clr.shadeWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(size.w8)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.w16, top: size.h32, right: size.w16),
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.imgEmptyProfile,
                      height: size.h32,
                    ),
                    SizedBox(width: size.w12),
                    Expanded(
                      child: Text(
                        label(e: en.userNameText, b: bn.userNameText),
                        style: TextStyle(
                            color: clr.appPrimaryColorBlack,
                            fontSize: size.textXMedium,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.h24),
              Padding(
                padding: EdgeInsets.only(left: size.w16),
                child: CustomSwitchButton(
                  value: App.currentAppLanguage == AppLanguage.english,
                  textOn: 'EN',
                  textSize: size.textXXSmall,
                  textOff: 'বাং',
                  bgColor: clr.whiteColor,
                  width: 64.w,
                  animationDuration: const Duration(milliseconds: 300),
                  onChanged: (bool state) {
                    App.setAppLanguage(state ? 1 : 0).then((value) {
                      if (mounted) {
                        setState(() {});
                      }
                      AppEventsNotifier.notify(EventAction.bottomNavBar);
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
              ),
              SizedBox(height: size.h12),
              Container(height: size.h1, color: clr.cardStrokeColorMauve),
              DrawerLinkWidget(
                icon: Icons.contact_support,
                text: label(e: en.aboutUs, b: bn.aboutUs),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.local_library,
                text: label(e: en.lms, b: bn.lms),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.auto_stories,
                text: label(e: en.teachersGuide, b: bn.teachersGuide),
                onTap: () {},
              ),
              DrawerLinkWidget(
                svgIcon: ImageAssets.icBook,
                text: label(e: en.eLibrary, b: bn.eLibrary),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.assignment,
                text:
                    label(e: en.formativeAssessment, b: bn.formativeAssessment),
                onTap: () {},
              ),
              DrawerLinkWidget(
                svgIcon: ImageAssets.icSocialLearning,
                text: label(
                    e: en.socialLearningPlatform, b: bn.socialLearningPlatform),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.play_circle,
                text: label(e: en.tutorial, b: bn.tutorial),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.chat_bubble,
                text: label(e: en.messageText, b: bn.messageText),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.event_note_sharp,
                text: label(e: en.notesText, b: bn.notesText),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoute.noteScreen),
              ),
              DrawerLinkWidget(
                icon: Icons.book,
                text: label(e: en.bookRequestText, b: bn.bookRequestText),
                onTap: () => Navigator.of(context)
                    .pushNamed(AppRoute.bookRequestListScreen),
              ),
              DrawerLinkWidget(
                icon: Icons.book,
                text: label(e: en.bookReportText, b: bn.bookReportText),
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoute.bookViewDownloadCountScreen);
                },
              ),
              DrawerLinkWidget(
                icon: Icons.logout,
                iconColor: clr.textColorBlack,
                text: label(e: en.logoutText, b: bn.logoutText),
                onTap: showLogoutPromptDialog,
              ),
              SizedBox(height: size.h64)
            ],
          ),
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
}

class DrawerLinkWidget extends StatelessWidget with AppTheme {
  final IconData? icon;
  final Color? iconColor;
  final String? svgIcon;
  final String text;
  final VoidCallback onTap;
  const DrawerLinkWidget({
    Key? key,
    this.icon,
    this.iconColor,
    this.svgIcon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              bottom:
                  BorderSide(width: size.h1, color: clr.cardStrokeColorMauve)),
        ),
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: size.w10),
                child: Icon(
                  icon,
                  size: size.r24,
                  color: iconColor ?? clr.iconColorHint,
                ),
              ),
            if (svgIcon != null)
              Padding(
                padding: EdgeInsets.only(right: size.w10),
                child: SvgPicture.asset(
                  svgIcon!,
                  height: size.h24,
                  colorFilter:
                      ColorFilter.mode(clr.iconColorHint, BlendMode.srcIn),
                  // color: clr.hintIconColor,
                ),
              ),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
