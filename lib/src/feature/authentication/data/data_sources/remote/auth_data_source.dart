import '../../../../../core/service/auth_cache_manager.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../models/auth_data_model.dart';

abstract class AuthRemoteDataSource {
  Future<ResponseModel> getTokenAction(String username, String eMISToken);
  Future<void> refreshTokenAction();
  Future<ResponseModel> getEMISLinkAction();
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  @override
  Future<ResponseModel> getTokenAction(
      String username, String eMISToken) async {
    final responseJson = await Server.instance.getRequestForAuth(
        url: "${ApiCredential.getToken}?username=$username&token=$eMISToken");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AuthDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getEMISLinkAction() async {
    final responseJson =
        await Server.instance.getRequestForAuth(url: ApiCredential.getEMISLink);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AuthDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<void> refreshTokenAction() async{
    final responseJson = await Server.instance.postRequestForAuth(url: ApiCredential.refreshToken);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AuthDataModel.fromJson(json));

    if (responseModel.data != null) {
      if (responseModel.data?.accessToken != null &&
          responseModel.data?.refreshToken != null &&
          responseModel.data?.expiresAt != null) {
        AuthCacheManager.storeUserInfo(responseModel.data?.accessToken,
            responseModel.data?.refreshToken, responseModel.data?.expiresAt);
      }
    }
  }
}
