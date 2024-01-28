import '../../data/data_sources/remote/report_data_source.dart';
import '../../data/repositories/report_repository_imp.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/use_cases/report_use_case.dart';

mixin class ReportService {
  ReportService._();
  final ReportUseCase _reportUseCase = ReportUseCase(
      reportRepository: ReportRepositoryImp(
          reportRemoteDataSource: ReportRemoteDataSourceImp()));

  Future<ResponseEntity> getBookViewDownloadReport(
      String startDate, String endDate) async {
    return _reportUseCase.getBookViewDownloadReportUseCase(startDate, endDate);
  }
}
