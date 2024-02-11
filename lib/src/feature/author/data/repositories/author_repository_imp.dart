import '../mapper/paginated_author_data_mapper.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../shared/data/models/response_model.dart';
import '../../domain/entities/paginated_author_data_entity.dart';
import '../../domain/repositories/author_repository.dart';
import '../data_sources/remote/author_data_source.dart';
import '../models/paginated_author_data_model.dart';

class AuthorRepositoryImp extends AuthorRepository {
  final AuthorRemoteDataSource authorRemoteDataSource;
  AuthorRepositoryImp({required this.authorRemoteDataSource});

  @override
  Future<ResponseEntity> getAuthors() async {
    ResponseModel responseModel =
        (await authorRemoteDataSource.getAuthorsAction());
    return ResponseModelToEntityMapper<PaginatedAuthorDataEntity,
            PaginatedAuthorDataModel>()
        .toEntityFromModel(
            responseModel,
            (PaginatedAuthorDataModel model) =>
                model.toPaginatedAuthorDataEntity);
  }
}
