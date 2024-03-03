import 'package:elibrary/src/feature/profile/presentation/widgets/progress_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/service/auth_cache_manager.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/profile_data_entity.dart';

class PersonalInfoWidget extends StatelessWidget with AppTheme, Language {
  final ProfileDataEntity profileDataEntity;
  const PersonalInfoWidget({super.key, required this.profileDataEntity});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.h24),
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
              title: label(e: en.positionNameText, b: bn.positionNameText)),
          TitleWithIcon(
            icon: Icons.badge,
            title: profileDataEntity.empId,
            // title:
            //     label(e: en.regNoText, b: bn.regNoText),
          ),
          TitleWithIcon(
            icon: Icons.phone,
            title: profileDataEntity.mobileNo,
            // title: label(
            //     e: en.phoneNumberText,
            //     b: bn.phoneNumberText),
          ),
          TitleWithIcon(
            onTap: () {},
            icon: Icons.email,
            title: profileDataEntity.email,
          ),
          /*TitleWithIcon(
            onTap: onTapNotes,
            icon: Icons.event_note_sharp,
            title: label(e: "Notes", b: "Notes"),
          ),*/
          TitleWithIcon(
            icon: Icons.logout,
            title: label(e: en.logoutText, b: bn.logoutText),
            onTap: () => showLogoutPromptDialog(context),
            hasBorder: false,
          ),
        ],
      ),
    );
  }

  void showLogoutPromptDialog(BuildContext context) {
    CustomDialogWidget.show(
      context: context,
      title: label(e: en.logoutWarningText, b: bn.logoutWarningText),
      infoText: label(
          e: "Your ID login is required for your courses and assessment news.",
          b: "আপনার কোর্সগুলো এবং মূল্যায়নের খবরের জন্য আপনার আইডি লগইন থাকা প্রয়োজন।"),
      rightButtonText: label(e: en.exitText, b: bn.exitText),
      leftButtonText: label(e: en.cancelText, b: bn.cancelText),
    ).then((value) {
      if (value) {
        AuthCacheManager.userLogout();
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoute.authenticationScreen, (x) => false);
      }
    });
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
                color: clr.appSecondaryColorPurple,
                size: size.r20,
              ),
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon!,
                colorFilter: ColorFilter.mode(
                    clr.appSecondaryColorPurple, BlendMode.srcIn),
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
