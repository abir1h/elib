import '../mapper/author_data_mapper.dart';
import '../models/author_data_model.dart';
import '../../domain/entities/author_data_entity.dart';
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
  Future<ResponseEntity> getAuthors(int currentPage) async {
    ResponseModel responseModel =
        (await authorRemoteDataSource.getAuthorsAction(currentPage));
    return ResponseModelToEntityMapper<PaginatedAuthorDataEntity,
            PaginatedAuthorDataModel>()
        .toEntityFromModel(
            responseModel,
            (PaginatedAuthorDataModel model) =>
                model.toPaginatedAuthorDataEntity);
  }

  @override
  Future<ResponseEntity> getBookByAuthors(int authorId) async {
    ResponseModel responseModel =
        (await authorRemoteDataSource.getBookByAuthorsAction(authorId));
    return ResponseModelToEntityMapper<List<AuthorDataEntity>,
            List<AuthorDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<AuthorDataModel> models) => List<AuthorDataModel>.from(models)
                .map((e) => e.toAuthorDataEntity)
                .toList());
  }
}
