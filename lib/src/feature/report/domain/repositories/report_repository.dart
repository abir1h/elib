import '../../../shared/domain/entities/response_entity.dart';

abstract class ReportRepository {
  Future<ResponseEntity> getBookViewDownloadReport(String startDate, String endDate);

}
