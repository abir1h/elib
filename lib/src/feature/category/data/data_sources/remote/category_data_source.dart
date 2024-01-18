import 'dart:convert';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/category_data_model.dart';

abstract class CategoryRemoteDataSource {
  Future<ResponseModel> getCategoriesAction();
}

class CategoryRemoteDataSourceImp extends CategoryRemoteDataSource {

  @override
  Future<List<CategoryDataModel>> getCategoriesActio() async{
    final responseJson = await Server.instance.getRequest(url: ApiCredential.getCategories);
    List<CategoryDataModel> responseModel = CategoryDataModel.listFromJson(jsonDecode(responseJson["data"]));
    // ResponseModel responseModel = ResponseModel.fromJson(
    //     json.decode(responseJson),
    //         (dynamic json) => CategoryDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getCategoriesAction() {
    // TODO: implement getCategoriesAction
    throw UnimplementedError();
  }
}