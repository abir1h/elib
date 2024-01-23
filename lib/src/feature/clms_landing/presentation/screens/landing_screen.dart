import 'package:flutter/material.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/routes/app_routes.dart';
import '../widgets/module_card_widget.dart';
import '../widgets/row_item_template.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/language.dart';
import '../services/landing_service.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with AppTheme, Language, LandingService {
  ///Service configurations
  @override
  void initState() {
    super.initState();

    ///Init notification and firebase
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: clr.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: clr.secondaryBackgroundColor,
          title: Text(
            label(e: en.appNameText, b: bn.appNameText),
            style: TextStyle(
                color: clr.appPrimaryColorGreen,
                fontSize: size.textXMedium,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyPoppins),
          ),
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(size.h1),
              child: Container(
                color: clr.cardStrokeColor,
                height: size.h1,
              )),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
          child: Column(
            children: [
              RowItemTemplate(
                  leftChild: ModuleCardWidget(
                    image: ImageAssets.imgModule1,
                    text: label(
                        e: en.learningManagementSystem,
                        b: bn.learningManagementSystem),
                    onTap: () {},
                  ),
                  rightChild: ModuleCardWidget(
                    image: ImageAssets.imgModule2,
                    text: label(e: en.teachersGuide, b: bn.teachersGuide),
                  )),
              SizedBox(height: size.h16),
              RowItemTemplate(
                leftChild: ModuleCardWidget(
                    image: ImageAssets.imgModule3,
                    text: label(e: en.eLibrary, b: bn.eLibrary),
                    onTap: onNavigateToELibraryScreen),
                rightChild: ModuleCardWidget(
                  image: ImageAssets.imgModule4,
                  text: label(
                      e: en.formativeAssessment, b: bn.formativeAssessment),
                ),
              ),
              SizedBox(height: size.h16),
              RowItemTemplate(
                  leftChild: ModuleCardWidget(
                    image: ImageAssets.imgModule2,
                    text: label(
                        e: en.socialLearningPlatform,
                        b: bn.socialLearningPlatform),
                  ),
                  rightChild: Container()),
            ],
          ),
        ));
  }

  @override
  void navigateToELibraryScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.baseScreen, (x) => false);
  }

  ///Push Notification Section
  /* void _onFCMTokenUpdate(String? token) async {
    print(token);
  }

  void onNotificationClicked(NotificationEntity notification,
      {bool isFromTray = true}) async {
    // try{
    //   ///Is notification clicked from system tray then wait some time to finish loading
    //   if(isFromTray) await Future.delayed(const Duration(milliseconds: 500));
    //
    //
    //   ///Mark notification as seen
    //   _markNotificationAsSeen(notification);
    // }
    // catch (error){
    //   debugPrint(error.toString());
    // }
    Navigator.of(AppRoutes.navigatorKey.currentContext!).push(
        MaterialPageRoute(builder: (context) => const NotificationScreen()));
  }

  void _onNotificationReceived(NotificationEntity notification) async {}
  void _markNotificationAsSeen(NotificationEntity notification) {}*/
}
