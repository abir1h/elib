import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/note_data_model.dart';
import '../../models/paginated_note_data_model.dart';

abstract class NoteRemoteDataSource {
  Future<ResponseModel> getNoteListAction(bool enablePagination,
      {int? pageNumber});
}

class NoteRemoteDataSourceImp extends NoteRemoteDataSource {
  @override
  Future<ResponseModel> getNoteListAction(bool enablePagination,
      {int? pageNumber}) async {
    String url = pageNumber != null
        ? "${ApiCredential.noteBooks}$enablePagination&page=$pageNumber"
        : "${ApiCredential.noteBooks}$enablePagination";
    final responseJson = await Server.instance.getRequest(url: url);
    ResponseModel responseModel = enablePagination
        ? ResponseModel.fromJson(responseJson,
            (dynamic json) => PaginatedNoteDataModel.fromJson(json))
        : ResponseModel.fromJson(
            responseJson, (dynamic json) => NoteDataModel.listFromJson(json));
    return responseModel;
  }
}
