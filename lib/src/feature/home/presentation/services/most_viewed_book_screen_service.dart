import 'package:flutter/material.dart';

import '../../../book/domain/entities/book_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBookDetailsScreen(BookDataEntity data);
}

mixin MostViewedBookScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  void onBookContentSelected(BookDataEntity item) {
    _view.navigateToBookDetailsScreen(item);
  }
}
