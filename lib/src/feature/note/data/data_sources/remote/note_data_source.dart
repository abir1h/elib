import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/note_data_model.dart';
import '../../models/paginated_note_data_model.dart';

abstract class NoteRemoteDataSource {
  Future<ResponseModel> getNoteListAction(bool enablePagination,
      {int? pageNumber});
  Future<ResponseModel> createNotesAction(NoteDataModel noteDataModel);
  Future<ResponseModel> updateNotesAction(NoteDataModel noteDataModel);
  Future<ResponseModel> deleteNotesAction(int noteId);
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

  @override
  Future<ResponseModel> createNotesAction(NoteDataModel noteDataModel) async {
    final responseJson = await Server.instance.postRequest(
        url: ApiCredential.noteBookCreate, postData: noteDataModel);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateNotesAction(NoteDataModel noteDataModel) async {
    Map<String, dynamic> data = noteDataModel.toJson();
    data["_method"] = "PUT";
    final responseJson = await Server.instance.postRequest(
        url: "${ApiCredential.noteBookUpdate}${noteDataModel.id}",
        postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> deleteNotesAction(int noteId) async {
    final responseJson = await Server.instance
        .deleteRequest(url: "${ApiCredential.noteBookDelete}$noteId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }
}
