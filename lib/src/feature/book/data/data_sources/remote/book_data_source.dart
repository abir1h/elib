import 'package:elibrary/src/feature/book/data/models/paginated_book_data_model.dart';
import 'package:elibrary/src/feature/category/data/models/paginated_category_data_model.dart';

import '../../models/book_data_model.dart';
import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class BookRemoteDataSource {
  Future<ResponseModel> getBooksAction();
  Future<ResponseModel> getPopularBooksAction(int pageNumber);
  Future<ResponseModel> getBookDetailsAction(int bookId);
  Future<ResponseModel> saveBookAction(int bookId, int status);
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
  Future<ResponseModel> saveBookAction(int bookId, int status) async{
    Map<String, dynamic> data = {
      "book_id": bookId,
      "status": status
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.saveBook, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => null);
    return responseModel;
  }

  @override
  Future<ResponseModel> getPopularBooksAction(int pageNumber) async{
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.popularBooks}$pageNumber");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => PaginatedBookDataModel.fromJson(json));
    return responseModel;
  }

}
