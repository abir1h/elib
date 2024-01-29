import '../mapper/bookamark_data_mapper.dart';
import '../mapper/bookmark_response_mapper.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../shared/data/models/response_model.dart';
import '../../domain/entities/bookmark_data_entity.dart';
import '../../domain/entities/bookmark_response_entity.dart';
import '../../domain/repositories/book_mark_repository.dart';
import '../data_sources/remote/bookmark_data_source.dart';
import '../models/bookmark_data_model.dart';
import '../models/bookmark_response_model.dart';

class BookmarkRepositoryImp extends BookmarkRepository {
  final BookmarkRemoteDataSource bookmarkRemoteDataSource;
  BookmarkRepositoryImp({required this.bookmarkRemoteDataSource});

  @override
  Future<ResponseEntity> bookmarkBook(int bookId, int eMISUserId) async {
    ResponseModel responseModel =
        (await bookmarkRemoteDataSource.bookmarkBookAction(bookId, eMISUserId));
    return ResponseModelToEntityMapper<BookmarkResponseEntity,
            BookmarkResponseModel>()
        .toEntityFromModel(responseModel,
            (BookmarkResponseModel model) => model.toBookmarkResponseEntity);
  }

  @override
  Future<ResponseEntity> getBookmarkBookList() async {
    ResponseModel responseModel =
        (await bookmarkRemoteDataSource.getBookmarkBooksAction());
    return ResponseModelToEntityMapper<List<BookmarkDataEntity>,
            List<BookmarkDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<BookmarkDataModel> model) =>
                List<BookmarkDataModel>.from(model)
                    .map((e) => e.toBookmarkDataEntity)
                    .toList());
  }
}
