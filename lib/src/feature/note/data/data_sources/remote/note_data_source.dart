import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/paginated_note_data_model.dart';

abstract class NoteRemoteDataSource {
  Future<ResponseModel> getNoteListAction();
}

class NoteRemoteDataSourceImp extends NoteRemoteDataSource {
  @override
  Future<ResponseModel> getNoteListAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.noteBooks);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => PaginatedNoteDataModel.fromJson(json));
    return responseModel;
  }
}
