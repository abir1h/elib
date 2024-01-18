import 'package:flutter/material.dart';

abstract class _ViewModel {
  void navigateToLandingScreen();
}

mixin SplashService implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchUserSession();
    });
  }

  //======================Private methods======================
  ///Fetch users from local database
  void _fetchUserSession() async {
    ///Delayed for 2 seconds
    await Future.delayed(const Duration(milliseconds: 500));

    ///Navigate to logical page
    _view.navigateToLandingScreen();
  }
}
