import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../book/domain/entities/book_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToBookDetailsScreen(BookDataEntity data);
}

mixin CategoryDetailsScreenService<T extends StatefulWidget> on State<T>
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
  ///Stream controllers
  final AppStreamController<List<BookDataEntity>>
  bookDataStreamController = AppStreamController();


  void onBookContentSelected(BookDataEntity item) {
    _view.navigateToBookDetailsScreen(item);
  }
}
