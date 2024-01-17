import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_action_button.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/validator.dart';
import '../../../../core/utility/log.dart';

class AuthenticationController extends GetxController with AppTheme {
  /*AuthenticationController(this._authenticationUseCase);
  final AuthUseCase _authenticationUseCase;

  final localStorage = Get.find<LocalStorageService>();
  final isLogged = false.obs;
  final watchPassword = true.obs;

  final userIdEditingController = TextEditingController(text: "2016810150");
  final passwordEditingController = TextEditingController(text: "password");
  late final FocusNode userIdFocusNode = FocusNode();
  late final FocusNode passFocusNode = FocusNode();
  CustomActionButtonController buttonController =
      CustomActionButtonController();*/

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void dispose() {
  /*  userIdEditingController.dispose();
    passwordEditingController.dispose();
    userIdFocusNode.dispose();
    passFocusNode.dispose();*/
    super.dispose();
  }

  void toggleWatchPassword(bool status) {
    // watchPassword(status);
  }

  void toggleAuth(bool status) {
    // isLogged(status);
  }

/*  Future<void> loginUserAccount(String userId, String password) async {
    final authorization =
        await _authenticationUseCase.userLoginUseCase(userId, password);
    if (authorization.errors == null) {
      buttonController.successTap();
      Future.delayed(const Duration(milliseconds: 800)).then((value) {
        if (authorization.data != null &&
            authorization.data!.accessToken.isNotEmpty) {
          appPrint(authorization.data!.accessToken);
          appPrint(authorization.data!.refreshToken);
          _saveUserInfo(
              authorization.data!.accessToken,
              authorization.data!.refreshToken,
              authorization.data!.role,
              authorization.data!.permissions.toString());
          // _saveUser(email);
          Get.offNamed(AppRoutes.landing);
        }
      });
    } else {
      buttonController.errorTap();
      Get.snackbar(
        "Error",
        authorization.message.toString(),
        icon: const Icon(Icons.error, color: Colors.black),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: clr.whiteColor,
      );
    }
  }

  bool validateLoginForeignFormData(
      TextEditingController userId, TextEditingController pass) {
    if (Validator.isEmpty(userId.text)) {
      Get.snackbar(
        "Error",
        "User id is empty !",
        icon: const Icon(Icons.error, color: Colors.black),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: clr.whiteColor,
      );
      return false;
    } else if (Validator.isEmpty(pass.text)) {
      Get.snackbar(
        "Error",
        "Password is empty !",
        icon: const Icon(Icons.error, color: Colors.black),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: clr.whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  _saveUserInfo(String accessToken, String refreshToken, String userRole,
      String userPermission) {
    localStorage.storeStringValue(StringData.accessTokenKey, accessToken);
    localStorage.storeStringValue(StringData.refreshTokenKey, refreshToken);
    localStorage.storeStringValue(StringData.userRoleKey, userRole);
    localStorage.storeStringValue(StringData.userPermissionKey, userPermission);
  }*/
  // _saveUser(String email){
  //   localStorage.storeStringValue(StringData.emailKey, email);
  // }
}
