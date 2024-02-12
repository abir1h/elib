import '../../../../report/data/models/book_report_data_model.dart';
import '../../models/progress_data_model.dart';
import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class ProgressRemoteDataSource {
  Future<ResponseModel> getProgressCountsAction();
  Future<ResponseModel> getUserReadBooksAction();
}

class ProgressRemoteDataSourceImp extends ProgressRemoteDataSource {
  @override
  Future<ResponseModel> getProgressCountsAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.userProgressCount);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => ProgressDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getUserReadBooksAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.userReadBooks);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookReportDataModel.listFromJson(json));
    return responseModel;
  }
}
