import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/paginated_author_data_model.dart';

abstract class AuthorRemoteDataSource {
  Future<ResponseModel> getAuthorsAction();
}

class AuthorRemoteDataSourceImp extends AuthorRemoteDataSource {
  @override
  Future<ResponseModel> getAuthorsAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getAuthors);
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => PaginatedAuthorDataModel.fromJson(json));
    return responseModel;
  }
}
