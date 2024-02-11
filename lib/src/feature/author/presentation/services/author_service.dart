import '../../data/data_sources/remote/author_data_source.dart';
import '../../data/repositories/author_repository_imp.dart';
import '../../domain/use_cases/author_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

mixin class AuthorService {
  AuthorService._();
  final AuthorUseCase _authorUseCase = AuthorUseCase(
      authorRepository: AuthorRepositoryImp(
          authorRemoteDataSource: AuthorRemoteDataSourceImp()));

  Future<ResponseEntity> getAuthors() async {
    return _authorUseCase.getAuthorsUseCase();
  }
}
