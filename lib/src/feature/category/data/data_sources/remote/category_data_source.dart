import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/paginated_category_data_model.dart';
import '../../models/category_data_model.dart';

abstract class CategoryRemoteDataSource {
  Future<ResponseModel> getCategoriesAction();
  Future<ResponseModel> getCategoryWithBookAction();
}

class CategoryRemoteDataSourceImp extends CategoryRemoteDataSource {

  @override
  Future<ResponseModel> getCategoriesAction() async{
    final responseJson = await Server.instance.getRequest(url: ApiCredential.getCategories);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson,
            (dynamic json) => CategoryDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getCategoryWithBookAction() async{
    final responseJson = await Server.instance.getRequest(url: ApiCredential.getCategoryWithBook);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson,
            (dynamic json) => PaginatedCategoryDataModel.fromJson(json));
    return responseModel;
  }

}