import '../../../book/data/mapper/book_data_mapper.dart';
import '../../domain/entities/note_data_entity.dart';
import '../models/note_data_model.dart';

abstract class NoteDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _NoteDataModelToEntityMapper
    extends NoteDataMapper<NoteDataModel, NoteDataEntity> {
  @override
  NoteDataModel fromEntityToModel(NoteDataEntity entity) {
    return NoteDataModel(
        id: entity.id,
        bookId: entity.bookId,
        emisUserId: entity.emisUserId,
        note: entity.note,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt,
        book: entity.book?.toBookDataModel);
  }

  @override
  NoteDataEntity toEntityFromModel(NoteDataModel model) {
    return NoteDataEntity(
        id: model.id,
        bookId: model.bookId,
        emisUserId: model.emisUserId,
        note: model.note,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt,
        book: model.book?.toBookDataEntity);
  }
}

extension NoteDataModelExt on NoteDataModel {
  NoteDataEntity get toNoteDataEntity =>
      _NoteDataModelToEntityMapper().toEntityFromModel(this);
}

extension NoteDataEntityExt on NoteDataEntity {
  NoteDataModel get toNoteDataModel =>
      _NoteDataModelToEntityMapper().fromEntityToModel(this);
}
