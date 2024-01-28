import 'note_data_mapper.dart';
import '../../domain/entities/note_data_entity.dart';
import '../../domain/entities/paginated_note_data_entity.dart';
import '../models/note_data_model.dart';
import '../models/paginated_note_data_model.dart';

abstract class PaginatedNoteDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _PaginatedNoteDataModelToEntityMapper extends PaginatedNoteDataMapper<
    PaginatedNoteDataModel, PaginatedNoteDataEntity> {
  @override
  PaginatedNoteDataModel fromEntityToModel(PaginatedNoteDataEntity entity) {
    return PaginatedNoteDataModel(
        currentPage: entity.currentPage,
        noteDataModel: List<NoteDataEntity>.from(entity.noteDataEntity)
            .map((entity) => entity.toNoteDataModel)
            .toList(),
        firstPageUrl: entity.firstPageUrl,
        from: entity.from,
        lastPage: entity.lastPage,
        lastPageUrl: entity.lastPageUrl,
        nextPageUrl: entity.nextPageUrl,
        path: entity.path,
        perPage: entity.perPage,
        prevPageUrl: entity.prevPageUrl,
        to: entity.to,
        total: entity.total);
  }

  @override
  PaginatedNoteDataEntity toEntityFromModel(PaginatedNoteDataModel model) {
    return PaginatedNoteDataEntity(
        currentPage: model.currentPage,
        noteDataEntity: List<NoteDataModel>.from(model.noteDataModel)
            .map((model) => model.toNoteDataEntity)
            .toList(),
        firstPageUrl: model.firstPageUrl,
        from: model.from,
        lastPage: model.lastPage,
        lastPageUrl: model.lastPageUrl,
        nextPageUrl: model.nextPageUrl,
        path: model.path,
        perPage: model.perPage,
        prevPageUrl: model.prevPageUrl,
        to: model.to,
        total: model.total);
  }
}

extension CategoryBookDataModelExt on PaginatedNoteDataModel {
  PaginatedNoteDataEntity get toPaginatedNoteDataEntity =>
      _PaginatedNoteDataModelToEntityMapper().toEntityFromModel(this);
}

extension CategoryBookDataEntityExt on PaginatedNoteDataEntity {
  PaginatedNoteDataModel get toPaginatedNoteDataModel =>
      _PaginatedNoteDataModelToEntityMapper().fromEntityToModel(this);
}
