import 'package:elibrary/src/feature/note/data/mapper/note_data_mapper.dart';

import '../../domain/entities/note_data_entity.dart';
import '../mapper/paginated_note_data_mapper.dart';
import '../../domain/entities/paginated_note_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../data_sources/remote/note_data_source.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/note_repository.dart';
import '../models/note_data_model.dart';
import '../models/paginated_note_data_model.dart';

class NoteRepositoryImp extends NoteRepository {
  final NoteRemoteDataSource noteRemoteDataSource;
  NoteRepositoryImp({required this.noteRemoteDataSource});

  @override
  Future<ResponseEntity> getNoteList(bool enablePagination,
      {int? pageNumber}) async {
    ResponseModel responseModel = (await noteRemoteDataSource
        .getNoteListAction(enablePagination, pageNumber: pageNumber));
    return ResponseModelToEntityMapper<PaginatedNoteDataEntity,
            PaginatedNoteDataModel>()
        .toEntityFromModel(responseModel,
            (PaginatedNoteDataModel model) => model.toPaginatedNoteDataEntity);
  }

  @override
  Future<ResponseEntity> createNotes(NoteDataEntity noteDataEntity) async {
    ResponseModel responseModel = (await noteRemoteDataSource
        .createNotesAction(noteDataEntity.toNoteDataModel));
    return ResponseModelToEntityMapper<NoteDataEntity, NoteDataModel>()
        .toEntityFromModel(
            responseModel, (NoteDataModel model) => model.toNoteDataEntity);
  }

  @override
  Future<ResponseEntity> updateNotes(NoteDataEntity noteDataEntity) async {
    ResponseModel responseModel = (await noteRemoteDataSource
        .updateNotesAction(noteDataEntity.toNoteDataModel));
    return ResponseModelToEntityMapper<NoteDataEntity, NoteDataModel>()
        .toEntityFromModel(
            responseModel, (NoteDataModel model) => model.toNoteDataEntity);
  }

  @override
  Future<ResponseEntity> deleteNotes(int noteId) async {
    ResponseModel responseModel =
        (await noteRemoteDataSource.deleteNotesAction(noteId));
    return ResponseModelToEntityMapper<NoteDataEntity, NoteDataModel>()
        .toEntityFromModel(
            responseModel, (NoteDataModel model) => model.toNoteDataEntity);
  }
}
