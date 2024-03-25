import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/personal_info_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/header_widget.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../service/profile_screen_service.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/routes/app_routes.dart';
import '../widgets/progress_info_widget.dart';
import '../widgets/tab_switch_widget.dart';

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
            HeaderWidget(
              title: label(e: en.myProfileText, b: bn.myProfileText),
              onTapNotification: onTapNotification,
            ),
            Expanded(
                child: Container(
              color: clr.scaffoldSecondaryBackgroundColor,
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
                                      color: clr.strokeToggleColorPurple,
                                      width: size.w1)),
                              child: CircleAvatar(
                                radius: 45.r,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                  ImageAssets.imgEmptyProfile,
                                ),
                              ),
                            ),
                            SizedBox(height: size.h12),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: size.w16),
                              child: Text(
                                // label(e: data.fullnameEn, b: data.fullnameBn),
                                label(e: en.userNameText, b: bn.userNameText),
                                style: TextStyle(
                                    color: clr.appSecondaryColorPurple,
                                    fontSize: size.textXMedium,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: StringData.fontFamilyRoboto),
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
                              left: size.w24, right: size.w16, top: size.h16),
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2).withOpacity(.2),
                          blurRadius: 4,
                          offset: const Offset(-2, 0),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: size.h40),
                          TabSwitchWidget(
                            onTabChange: onTabValueChange,
                          ),
                          AppStreamBuilder<StateType>(
                            stream: stateDataStreamController.stream,
                            loadingBuilder: (context) {
                              return const Center(child: CircularLoader());
                            },
                            dataBuilder: (context, data) {
                              if (data is ProfileDataState) {
                                return PersonalInfoWidget(
                                    profileDataEntity: data.profileDataEntity);
                              } else if (data is ProgressDataState) {
                                return ProgressInfoWidget(
                                    data: data.progressDataEntity,
                                    onTapBookReport: onTapBookReport,
                                    onTapRequestedBook: onTapRequestedBook,
                                    onTapReadBook: onTapReadBook);
                              } else {
                                return const EmptyWidget(
                                  icon: Icons.school_outlined,
                                  message: "No matching data found!",
                                );
                              }
                            },
                            emptyBuilder: (context, message, icon) =>
                                EmptyWidget(
                              message: message,
                              constraints: constraints,
                              offset: 350.w,
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            )),
          ],
        ),
      ),
    );
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
  void navigateToNotificationScreen() {
    Navigator.of(context).pushNamed(AppRoute.notificationScreen);
  }

  @override
  void navigateToBookReportScreen() {
    Navigator.of(context).pushNamed(AppRoute.bookViewDownloadCountScreen);
  }

  @override
  void navigateToRequestedBookScreen() {
    Navigator.of(context).pushNamed(AppRoute.bookRequestListScreen);
  }

  @override
  void navigateToReadBookScreen() {
    Navigator.of(context).pushNamed(AppRoute.readBooksScreen);
  }
}
