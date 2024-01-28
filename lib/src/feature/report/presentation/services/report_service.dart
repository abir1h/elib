import 'package:elibrary/src/feature/report/domain/entities/book_view_download_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/report_data_source.dart';
import '../../data/repositories/report_repository_imp.dart';
import '../../domain/use_cases/report_use_case.dart';

abstract class _ViewModel {
  void showSuccess(String value);
  void showWarning(String value);
}

mixin ReportService<T extends StatefulWidget> on State<T>
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
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (selected != null) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(selected);

        startDate = formattedDate;
        selectedStartDate = selected;
      });
    }
  }

  Future<void> selectEndDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate:selectedStartDate,
      firstDate: selectedStartDate!,
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (selected != null) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(selected);

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
    // _loadBookmarkListData();
  }

  @override
  void dispose() {
    reportDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<BookViewDownloadDataEntity>>
      reportDataStreamController = AppStreamController();


  ///Load Category list
   Future<ResponseEntity> getReportList(String startDate,String endDate) async {

     ResponseEntity responseEntity = await getBookViewDownloadReport(startDate,endDate);
     if (responseEntity.error == null && responseEntity.data != null) {
       // reportDataStreamController
       //     .add(DataLoadedState<List<BookViewDownloadDataEntity>>(data));
       // if (_viewDownloadList.isEmpty) {
       //   reportDataStreamController
       //       .add(EmptyState(message: 'No Book Found'));
       // }
       // _view.showSuccess("Report list imported");
     } else {
       _view.showWarning(responseEntity.message!);
     }
     return responseEntity;
    // if (!mounted) return;
    // bookmarkDataStreamController.add(LoadingState());
    // getBookViewDownloadReport(startDate,endDate).then((value) {
    //   if (value.error == null && value.data.isNotEmpty) {
    //     _viewDownloadList = value.data;
    //     bookmarkDataStreamController
    //         .add(DataLoadedState<List<BookViewDownloadDataEntity>>(value.data!));
    //   } else if (value.error == null && value.data.isEmpty) {
    //     bookmarkDataStreamController.add(EmptyState(message: 'No Book Found'));
    //   } else {
    //     //_view.showWarning(value.message!);
    //   }
    //
    // });
  }
}
