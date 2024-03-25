import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../bookmark/data/data_sources/remote/bookmark_data_source.dart';
import '../../../bookmark/data/repositories/bookmark_repository_imp.dart';
import '../../../bookmark/domain/use_cases/book_mark_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBookDetailsScreen(BookDataEntity data);
}

mixin LatestBookScreenService<T extends StatefulWidget> on State<T>
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
