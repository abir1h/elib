import '../../models/home_data_model.dart';
import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class HomeRemoteDataSource {
  Future<ResponseModel> getHomeAction();
}

class HomeRemoteDataSourceImp extends HomeRemoteDataSource {
  @override
  Future<ResponseModel> getHomeAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getHome);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => HomeDataModel.fromJson(json));
    return responseModel;
  }
}
