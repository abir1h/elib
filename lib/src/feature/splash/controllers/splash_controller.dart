import 'dart:async';
import 'package:get/get.dart';

import '../../../core/config/local_storage_services.dart';
import '../../../core/constants/common_imports.dart';
import '../../../core/routes/app_routes.dart';



class SplashController extends GetxController {

  @override
  void onInit() {
    Timer(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.landing);
    });
    super.onInit();
  }

 /* Future<void> _navigateBasedOnLogin() async {
    final loggedIn = await _isLoggedIn();

    if (loggedIn) {
      Get.offNamed(AppRoutes.landing);
    } else {
      Get.offNamed(AppRoutes.landing);
    }
  }

  Future<bool> _isLoggedIn() async {
    isLogged.value =
        localStorage.getStringValue(StringData.accessTokenKey) != null;
    return isLogged.value;
  }*/
}
