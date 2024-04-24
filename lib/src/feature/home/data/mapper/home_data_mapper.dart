import '../../../report/data/models/book_report_data_model.dart';
import '../../../report/data/mapper/book_report_data_mapper.dart';
import '../../../report/domain/entities/book_report_data_entity.dart';
import '../../../book/data/mapper/book_data_mapper.dart';
import '../../../book/data/models/book_data_model.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../category/data/mapper/category_data_mapper.dart';
import '../../../category/data/models/category_data_model.dart';
import '../../../category/domain/entities/category_data_entity.dart';
import '../../../author/data/mapper/author_data_mapper.dart';
import '../../../author/data/models/author_data_model.dart';
import '../../../author/domain/entities/author_data_entity.dart';
import '../../domain/entities/home_data_entity.dart';
import '../models/home_data_model.dart';

abstract class HomeDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _HomeDataModelToEntityMapper
    extends HomeDataMapper<HomeDataModel, HomeDataEntity> {
  @override
  HomeDataModel fromEntityToModel(HomeDataEntity entity) {
    return HomeDataModel(
        latestBook: List<BookDataEntity>.from(entity.latestBook)
            .map((entity) => entity.toBookDataModel)
            .toList(),
        mostViewedBooks: List<BookReportDataEntity>.from(entity.mostViewedBooks)
            .map((entity) => entity.toBookReportDataModel)
            .toList(),
        categoriesOne: List<CategoryDataEntity>.from(entity.categoriesOne)
            .map((entity) => entity.toCategoryDataModel)
            .toList(),
        categoriesTwo: List<CategoryDataEntity>.from(entity.categoriesTwo)
            .map((entity) => entity.toCategoryDataModel)
            .toList(),
        authors: List<AuthorDataEntity>.from(entity.authors)
            .map((entity) => entity.toAuthorDataModel)
            .toList());
  }

  @override
  HomeDataEntity toEntityFromModel(HomeDataModel model) {
    return HomeDataEntity(
        latestBook: List<BookDataModel>.from(model.latestBook)
            .map((model) => model.toBookDataEntity)
            .toList(),
        mostViewedBooks: List<BookReportDataModel>.from(model.mostViewedBooks)
            .map((model) => model.toBookReportDataEntity)
            .toList(),
        categoriesOne: List<CategoryDataModel>.from(model.categoriesOne)
            .map((model) => model.toCategoryDataEntity)
            .toList(),
        categoriesTwo: List<CategoryDataModel>.from(model.categoriesTwo)
            .map((model) => model.toCategoryDataEntity)
            .toList(),
        authors: List<AuthorDataModel>.from(model.authors)
            .map((model) => model.toAuthorDataEntity)
            .toList());
  }
}

extension HomeDataModelExt on HomeDataModel {
  HomeDataEntity get toHomeDataEntity =>
      _HomeDataModelToEntityMapper().toEntityFromModel(this);
}

extension HomeDataEntityExt on HomeDataEntity {
  HomeDataModel get toHomeDataModel =>
      _HomeDataModelToEntityMapper().fromEntityToModel(this);
}
