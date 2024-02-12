import 'package:elibrary/src/core/routes/app_route_args.dart';
import 'package:elibrary/src/feature/report/domain/entities/book_report_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/report_data_source.dart';
import '../../data/repositories/report_repository_imp.dart';
import '../../domain/use_cases/report_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin BookViewReportListScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final ReportUseCase _reportUseCase = ReportUseCase(
      reportRepository: ReportRepositoryImp(
          reportRemoteDataSource: ReportRemoteDataSourceImp()));

  Future<ResponseEntity> getBookViewDownloadReport(
      String startDate, String endDate) async {
    return _reportUseCase.getBookViewDownloadReportUseCase(startDate, endDate);
  }
  // late BookReportListScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    reportDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<BookReportDataEntity>>
      reportDataStreamController = AppStreamController();
  final AppStreamController<bool> actionButtonDataStreamController =
      AppStreamController();

  ///Load Category list
  Future<ResponseEntity> getReportList(
      BookReportListScreenArgs screenArgs) async {
    ResponseEntity responseEntity = await getBookViewDownloadReport(
        screenArgs.startDate, screenArgs.endDate);
    if (responseEntity.error == null && responseEntity.data != null) {
      if (responseEntity.data.isNotEmpty) {
        reportDataStreamController.add(
            DataLoadedState<List<BookReportDataEntity>>(responseEntity.data));
      } else {
        reportDataStreamController.add(EmptyState(message: 'No Book Found'));
      }
      actionButtonDataStreamController.add(DataLoadedState(true));
    } else {
      // _view.showWarning(responseEntity.message!);
      CustomToasty.of(context).showWarning("No Data Found");
      reportDataStreamController.add(EmptyState(message: 'No Book Found'));

      ///Todo
    }
    return responseEntity;
  }
}
