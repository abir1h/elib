import '../../models/book_report_data_model.dart';
import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class ReportRemoteDataSource {
  Future<ResponseModel> getBookViewDownloadReportAction(
      String startDate, String endDate);
}

class ReportRemoteDataSourceImp extends ReportRemoteDataSource {
  @override
  Future<ResponseModel> getBookViewDownloadReportAction(
      String startDate, String endDate) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.bookViewDownloadReport}?startDate=$startDate&endDate=$endDate");
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => BookReportDataModel.listFromJson(json));
    return responseModel;
  }
}
