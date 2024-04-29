import '../../models/book_details_data_model.dart';
import '../../models/paginated_book_request_data_model.dart';
import '../../models/book_request_data_model.dart';
import '../../models/download_count_response_model.dart';
import '../../../../bookmark/data/models/bookmark_data_model.dart';
import '../../../../bookmark/data/models/bookmark_response_model.dart';
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
  Future<ResponseModel> bookmarkBookAction(int bookId, int eMISUserId);
  Future<ResponseModel> getBookmarkBooksAction();
  Future<ResponseModel> userBookViewCountAction(int bookId);
  Future<ResponseModel> userBookDownloadCountAction(int bookId);
  Future<ResponseModel> globalSearchAction(String searchQuery, String type);
  Future<ResponseModel> getBookRequestsAction(bool enablePagination,
      {int? pageNumber});
  Future<ResponseModel> createBookRequestAction(
      BookRequestDataModel bookRequestDataModel);
  Future<ResponseModel> updateBookRequestAction(
      BookRequestDataModel bookRequestDataModel);
  Future<ResponseModel> deleteBookRequestAction(int bookRequestId);
  Future<ResponseModel> getBookRequestDetailsAction(int bookRequestId);
  Future<ResponseModel> getBooksByTagsAction(int tagId);
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
        responseJson, (dynamic json) => BookDetailsDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> bookmarkBookAction(int bookId, int eMISUserId) async {
    Map<String, dynamic> data = {
      "book_id": bookId,
      "emis_user_id": eMISUserId,
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
    // final responseJson = await Server.instance
    //     .postRequest(url: ApiCredential.bookCountUser, postData: data);
    final responseJson = await Server.instance.postRequest(
        url: "${ApiCredential.bookCountUser}?book_id=$bookId", postData: data);
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
  Future<ResponseModel> globalSearchAction(
      String searchQuery, String type) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.globalSearch}$searchQuery&lebel=$type");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookDataModel.listFromJson(json));
    // ResponseModel responseModel = ResponseModel.fromJson(
    //     responseJson, (dynamic json) => PaginatedBookDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getBookRequestsAction(bool enablePagination,
      {int? pageNumber}) async {
    String url = pageNumber != null
        ? "${ApiCredential.bookRequest}$enablePagination&page=$pageNumber"
        : "${ApiCredential.bookRequest}$enablePagination";
    final responseJson =
        await Server.instance.getRequest(url: "${ApiCredential.bookRequest}?page=$pageNumber");
    ResponseModel responseModel =
        // enablePagination
        //     ?
        ResponseModel.fromJson(responseJson,
            (dynamic json) => PaginatedBookRequestDataModel.fromJson(json))
        // : ResponseModel.fromJson(responseJson,
        //     (dynamic json) => BookRequestDataModel.listFromJson(json))
        ;
    return responseModel;
  }

  @override
  Future<ResponseModel> createBookRequestAction(
      BookRequestDataModel bookRequestDataModel) async {
    final responseJson = await Server.instance.postRequest(
        url: ApiCredential.bookRequest,
        postData: bookRequestDataModel.toJson());
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookRequestDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateBookRequestAction(
      BookRequestDataModel bookRequestDataModel) async {
    Map<String, dynamic> data = bookRequestDataModel.toJson();
    data["_method"] = "PUT";
    final responseJson = await Server.instance.postRequest(
        url: "${ApiCredential.bookRequest}/${bookRequestDataModel.id}",
        postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookRequestDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> deleteBookRequestAction(int bookRequestId) async {
    final responseJson = await Server.instance
        .deleteRequest(url: "${ApiCredential.bookRequest}/$bookRequestId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookRequestDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getBookRequestDetailsAction(int bookRequestId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.bookRequest}/$bookRequestId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookRequestDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getBooksByTagsAction(int tagId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getBookByTags}/$tagId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookDataModel.listFromJson(json['original']['book']));
    return responseModel;
  }
}
