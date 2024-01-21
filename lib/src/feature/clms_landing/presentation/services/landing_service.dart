import 'package:flutter/material.dart';

abstract class _ViewModel {
  void navigateToELibraryScreen();
}

mixin LandingService implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;


  }

  //======================Private methods======================
void onNavigateToELibraryScreen(){
    _view.navigateToELibraryScreen();
}



}
