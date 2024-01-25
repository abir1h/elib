import '../../../shared/domain/entities/response_entity.dart';

abstract class NoteRepository {
  Future<ResponseEntity> getNoteList();
}
