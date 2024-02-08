import 'package:elibrary/src/feature/report/domain/entities/book_view_download_data_entity.dart';
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
  void navigationToListScreen(String startDate, String endDate);
}

mixin BookViewReportScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  bool isStartFilter = false;
  String? startDate;
  String? endDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  Future<void> selectStartDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1998),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );

    if (selected != null) {
      setState(() {
        final formattedDate = DateFormat('dd-MM-yyyy').format(selected);

        startDate = formattedDate;
        selectedStartDate = selected;
      });
    }
  }

  Future<void> selectEndDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: selectedStartDate!,
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );

    if (selected != null) {
      setState(() {
        final formattedDate = DateFormat('dd-MM-yyyy').format(selected);

        endDate = formattedDate;
        selectedEndDate = selected;
      });
    }
  }

  final ReportUseCase _reportUseCase = ReportUseCase(
      reportRepository: ReportRepositoryImp(
          reportRemoteDataSource: ReportRemoteDataSourceImp()));

  Future<ResponseEntity> getBookViewDownloadReport(
      String startDate, String endDate) async {
    return _reportUseCase.getBookViewDownloadReportUseCase(startDate, endDate);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    reportDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<BookViewDownloadDataEntity>>
      reportDataStreamController = AppStreamController();
  final AppStreamController<bool> actionButtonDataStreamController =
      AppStreamController();

  ///Load Category list
  Future<ResponseEntity> getReportList(String startDate, String endDate) async {
    ResponseEntity responseEntity =
        await getBookViewDownloadReport(startDate, endDate);
    if (responseEntity.error == null && responseEntity.data != null) {
      if (responseEntity.data.isNotEmpty) {
        reportDataStreamController.add(
            DataLoadedState<List<BookViewDownloadDataEntity>>(
                responseEntity.data));
      } else {
        reportDataStreamController.add(EmptyState(message: 'No Book Found'));
      }
      actionButtonDataStreamController.add(DataLoadedState(true));
    } else {
      // _view.showWarning(responseEntity.message!);
      CustomToasty.of(context).showWarning("No Data Found");

      ///Todo
    }
    return responseEntity;
  }

  onTapReport() {
    startDate = null;
    endDate = null;
    selectedStartDate = null;
    reportDataStreamController.add(LoadingState());
    actionButtonDataStreamController.add(LoadingState());
  }

  void onTapCategory(String startDate, String endDate) {
    _view.navigationToListScreen(startDate, endDate);
  }

  void onTapSeeReport(String startDate, String endDate) {
    _view.navigationToListScreen(startDate, endDate);
  }
}
