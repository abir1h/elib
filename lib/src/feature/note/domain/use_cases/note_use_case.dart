import '../../../shared/domain/entities/response_entity.dart';
import '../entities/note_data_entity.dart';
import '../repositories/note_repository.dart';

class NoteUseCase {
  final NoteRepository _noteRepository;
  NoteUseCase({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  Future<ResponseEntity> getNotesUseCase(bool enablePagination,
      {int? pageNumber}) async {
    final response =
        _noteRepository.getNoteList(enablePagination, pageNumber: pageNumber);
    return response;
  }

  Future<ResponseEntity> createNotesUseCase(
      NoteDataEntity noteDataEntity) async {
    final response = _noteRepository.createNotes(noteDataEntity);
    return response;
  }

  Future<ResponseEntity> updateNotesUseCase(
      NoteDataEntity noteDataEntity) async {
    final response = _noteRepository.updateNotes(noteDataEntity);
    return response;
  }

  Future<ResponseEntity> deleteNotesUseCase(int noteId) async {
    final response = _noteRepository.deleteNotes(noteId);
    return response;
  }
}
