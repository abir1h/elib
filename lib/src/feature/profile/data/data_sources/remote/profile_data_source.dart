import 'dart:convert';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/profile_data_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ResponseModel> userProfileInformationAction();
}

class ProfileRemoteDataSourceImp extends ProfileRemoteDataSource {
  @override
  Future<ResponseModel> userProfileInformationAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.userProfile);
    ResponseModel responseModel = ResponseModel.fromJson(
        json.decode(responseJson),
        (dynamic json) => ProfileDataModel.fromJson(json));
    return responseModel;
  }
}
