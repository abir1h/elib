import '../../../shared/domain/entities/response_entity.dart';
import '../entities/note_data_entity.dart';

abstract class NoteRepository {
  Future<ResponseEntity> getNoteList(bool enablePagination, {int? pageNumber});
  Future<ResponseEntity> createNotes(NoteDataEntity noteDataEntity);
  Future<ResponseEntity> updateNotes(NoteDataEntity noteDataEntity);
  Future<ResponseEntity> deleteNotes(int noteId);
}
