import 'package:flutter/material.dart';

import '../../../progress/data/data_sources/remote/progress_data_source.dart';
import '../../../progress/data/repositories/progress_repository_imp.dart';
import '../../../progress/domain/use_cases/progress_use_case.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../progress/domain/entities/progress_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToBookReportScreen();
  void navigateToRequestedBookScreen();
  void navigateToReadBookScreen();
}

mixin ProgressInfoService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final ProgressUseCase _progressUseCase = ProgressUseCase(
      progressRepository: ProgressRepositoryImp(
          progressRemoteDataSource: ProgressRemoteDataSourceImp()));

  Future<ResponseEntity> getProgressCounts() async {
    return _progressUseCase.getProgressCountsUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadProgressData();
  }

  @override
  void dispose() {
    progressDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<ProgressDataEntity> progressDataStreamController =
      AppStreamController();

  ///Load Progress data
  void _loadProgressData() {
    if (!mounted) return;
    progressDataStreamController.add(LoadingState());
    getProgressCounts().then((value) {
      if (value.error == null && value.data != null) {
        progressDataStreamController
            .add(DataLoadedState<ProgressDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTapBookReport() {
    _view.navigateToBookReportScreen();
  }

  void onTapRequestedBook() {
    _view.navigateToRequestedBookScreen();
  }

  void onTapReadBook() {
    _view.navigateToReadBookScreen();
  }
}
