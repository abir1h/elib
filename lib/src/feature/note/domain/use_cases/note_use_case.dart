import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/note_repository.dart';

class NoteUseCase {
  final NoteRepository _noteRepository;
  NoteUseCase({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  Future<ResponseEntity> getNotesUseCase() async {
    final response = _noteRepository.getNoteList();
    return response;
  }
}
