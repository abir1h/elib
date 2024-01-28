import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/report_repository.dart';

class ReportUseCase {
  final ReportRepository _reportRepository;
  ReportUseCase({required ReportRepository reportRepository})
      : _reportRepository = reportRepository;

  Future<ResponseEntity> getBookViewDownloadReportUseCase(String startDate, String endDate) async {
    final response = _reportRepository.getBookViewDownloadReport(startDate, endDate);
    return response;
  }

}
