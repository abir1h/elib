import '../../models/download_count_response_model.dart';
import '../../models/bookmark_data_model.dart';
import '../../models/bookmark_response_model.dart';
import '../../models/count_user_response_model.dart';
import '../../models/paginated_book_data_model.dart';
import '../../models/book_data_model.dart';
import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class BookRemoteDataSource {
  Future<ResponseModel> getBooksAction();
  Future<ResponseModel> getPopularBooksAction(int pageNumber);
  Future<ResponseModel> getBookDetailsAction(int bookId);
  Future<ResponseModel> bookmarkBookAction(
      int bookId, int eMISUserId, int status);
  Future<ResponseModel> getBookmarkBooksAction();
  Future<ResponseModel> userBookViewCountAction(int bookId);
  Future<ResponseModel> userBookDownloadCountAction(int bookId);
  Future<ResponseModel> globalSearchAction(String searchQuery);
}

class BookRemoteDataSourceImp extends BookRemoteDataSource {
  @override
  Future<ResponseModel> getBooksAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getBooks);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getBookDetailsAction(int bookId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getBookDetails}/$bookId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> bookmarkBookAction(
      int bookId, int eMISUserId, int status) async {
    Map<String, dynamic> data = {
      "book_id": bookId,
      "emis_user_id": eMISUserId,
      "status": status
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.bookmarkBook, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookmarkResponseModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getPopularBooksAction(int pageNumber) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.popularBooks}$pageNumber");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => PaginatedBookDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getBookmarkBooksAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getBookmarkBooks);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookmarkDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> userBookViewCountAction(int bookId) async {
    Map<String, dynamic> data = {
      "book_id": bookId,
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.bookCountUser, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CountUserResponseModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> userBookDownloadCountAction(int bookId) async {
    Map<String, dynamic> data = {
      "book_id": bookId,
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.downloadCountUser, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => DownloadCountResponseModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> globalSearchAction(String searchQuery) async{
    final responseJson = await Server.instance
        .getRequest(url: ApiCredential.globalSearch + searchQuery);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => PaginatedBookDataModel.fromJson(json));
    return responseModel;
  }
}
