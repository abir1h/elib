import '../../../../book/data/models/book_data_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/paginated_category_data_model.dart';
import '../../models/category_data_model.dart';

abstract class CategoryRemoteDataSource {
  Future<ResponseModel> getCategoriesAction();
  Future<ResponseModel> getCategoryWithBookAction();
  Future<ResponseModel> getCategoryByIdAction(int categoryId);
}

class CategoryRemoteDataSourceImp extends CategoryRemoteDataSource {
  @override
  Future<ResponseModel> getCategoriesAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getCategories);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CategoryDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getCategoryWithBookAction() async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getCategoryWithBook}?page=2");
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => PaginatedCategoryDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getCategoryByIdAction(int categoryId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.categoryDetailsById}$categoryId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookDataModel.listFromJson(json));
    return responseModel;
  }
}
