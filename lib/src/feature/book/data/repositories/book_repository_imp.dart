import '../mapper/paginated_book_data_mapper.dart';
import '../models/paginated_book_data_model.dart';
import '../../domain/entities/paginated_book_data_entity.dart';
import '../mapper/book_data_mapper.dart';
import '../models/book_data_model.dart';
import '../../domain/entities/book_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../shared/data/models/response_model.dart';
import '../../domain/repositories/book_repository.dart';
import '../data_sources/remote/book_data_source.dart';

class BookRepositoryImp extends BookRepository {
  final BookRemoteDataSource bookRemoteDataSource;
  BookRepositoryImp({required this.bookRemoteDataSource});

  @override
  Future<ResponseEntity> getBooks() async {
    ResponseModel responseModel = (await bookRemoteDataSource.getBooksAction());
    return ResponseModelToEntityMapper<List<BookDataEntity>,
            List<BookDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<BookDataModel> models) => List<BookDataModel>.from(models)
                .map((e) => e.toBookDataEntity)
                .toList());
  }

  @override
  Future<ResponseEntity> getBookDetails(int bookId) async {
    ResponseModel responseModel =
        (await bookRemoteDataSource.getBookDetailsAction(bookId));
    return ResponseModelToEntityMapper<BookDataEntity, BookDataModel>()
        .toEntityFromModel(
            responseModel, (BookDataModel model) => model.toBookDataEntity);
  }


  @override
  Future<ResponseEntity> getPopularBooks(int pageNumber) async{
    ResponseModel responseModel =
    (await bookRemoteDataSource.getPopularBooksAction(pageNumber));
    return ResponseModelToEntityMapper<PaginatedBookDataEntity,
    PaginatedBookDataModel>()
        .toEntityFromModel(responseModel,
    (PaginatedBookDataModel model) => model.toPaginatedBookDataEntity);
  }

  @override
  Future<ResponseEntity> bookmarkBook(int bookId, int eMISUserId, int status) async{
    ResponseModel responseModel =
    // (await bookRemoteDataSource.bookmarkBookAction(bookId, eMISUserId, status));
    // return ResponseModelToEntityMapper<ResponseEntity, ResponseModel>()
    //     .toEntityFromModel(
    // responseModel, (ResponseModel model) => model.toBookDataEntity);
    throw UnimplementedError();
  }

  @override
  Future<ResponseEntity> getBookmarkBookList() async{
    // ResponseModel responseModel =
    // (await bookRemoteDataSource.getBookmarkBooksAction());
    // return ResponseModelToEntityMapper<PaginatedBookDataEntity,
    // PaginatedBookDataModel>()
    //     .toEntityFromModel(responseModel,
    // (PaginatedBookDataModel model) => model.toPaginatedBookDataEntity);
    throw UnimplementedError();
  }
}
