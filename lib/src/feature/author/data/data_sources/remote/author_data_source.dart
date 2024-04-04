import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../book/data/models/book_data_model.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/paginated_author_data_model.dart';

abstract class AuthorRemoteDataSource {
  Future<ResponseModel> getAuthorsAction(int currentPage);
  Future<ResponseModel> getBookByAuthorsAction(int authorId);
}

class AuthorRemoteDataSourceImp extends AuthorRemoteDataSource {
  @override
  Future<ResponseModel> getAuthorsAction(int currentPage) async {
    final responseJson =
        await Server.instance.getRequest(url: "${ApiCredential.getAuthors}?page=$currentPage");
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => PaginatedAuthorDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getBookByAuthorsAction(int authorId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getBookByAuthors}/$authorId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookDataModel.listFromJson(json));
    return responseModel;
  }
}
