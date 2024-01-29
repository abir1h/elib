import '../../../../bookmark/data/models/bookmark_data_model.dart';
import '../../../../bookmark/data/models/bookmark_response_model.dart';
import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class BookmarkRemoteDataSource {
  Future<ResponseModel> bookmarkBookAction(int bookId, int eMISUserId);
  Future<ResponseModel> getBookmarkBooksAction();
}

class BookmarkRemoteDataSourceImp extends BookmarkRemoteDataSource {
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
  Future<ResponseModel> getBookmarkBooksAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getBookmarkBooks);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => BookmarkDataModel.listFromJson(json));
    return responseModel;
  }
}
