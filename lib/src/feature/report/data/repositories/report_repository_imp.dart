import '../mapper/book_report_data_mapper.dart';
import '../../domain/entities/book_report_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/report_repository.dart';
import '../data_sources/remote/report_data_source.dart';
import '../models/book_report_data_model.dart';

class ReportRepositoryImp extends ReportRepository {
  final ReportRemoteDataSource reportRemoteDataSource;
  ReportRepositoryImp({required this.reportRemoteDataSource});

  @override
  Future<ResponseEntity> getBookViewDownloadReport(
      String startDate, String endDate) async {
    ResponseModel responseModel = (await reportRemoteDataSource
        .getBookViewDownloadReportAction(startDate, endDate));
    return ResponseModelToEntityMapper<List<BookReportDataEntity>,
            List<BookReportDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<BookReportDataModel> models) =>
                List<BookReportDataModel>.from(models)
                    .map((e) => e.toBookReportDataEntity)
                    .toList());
  }
}
