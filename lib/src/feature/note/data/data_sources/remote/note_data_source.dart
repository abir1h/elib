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
        ? "${ApiCredential.getNoteBooks}$enablePagination&page=$pageNumber"
        : "${ApiCredential.getNoteBooks}$enablePagination";
    final responseJson =
        await Server.instance.getRequest(url: "${ApiCredential.getNoteBooks}?page=$pageNumber");
    ResponseModel responseModel = enablePagination
        ? ResponseModel.fromJson(responseJson,
            (dynamic json) => PaginatedNoteDataModel.fromJson(json))
        : ResponseModel.fromJson(
            responseJson, (dynamic json) => NoteDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> createNotesAction(NoteDataModel noteDataModel) async {
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.noteBook, postData: noteDataModel);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateNotesAction(NoteDataModel noteDataModel) async {
    Map<String, dynamic> data = noteDataModel.toJson();
    data["_method"] = "PUT";
    final responseJson = await Server.instance.postRequest(
        url: "${ApiCredential.noteBook}/${noteDataModel.id}", postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> deleteNotesAction(int noteId) async {
    final responseJson = await Server.instance
        .deleteRequest(url: "${ApiCredential.noteBook}/$noteId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }
}
