import '../repositories/author_repository.dart';
import '../../../shared/domain/entities/response_entity.dart';

class AuthorUseCase {
  final AuthorRepository _authorRepository;
  AuthorUseCase({required AuthorRepository authorRepository})
      : _authorRepository = authorRepository;

  Future<ResponseEntity> getAuthorsUseCase() async {
    final response = _authorRepository.getAuthors();
    return response;
  }

  Future<ResponseEntity> getBookByAuthorsUseCase(int authorId) async {
    final response = _authorRepository.getBookByAuthors(authorId);
    return response;
  }
}
