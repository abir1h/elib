import 'package:flutter/material.dart';

import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/note_data_source.dart';
import '../../data/repositories/note_repository_imp.dart';
import '../../domain/entities/note_data_entity.dart';
import '../../domain/use_cases/note_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin NoteEditScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final NoteUseCase _noteUseCase = NoteUseCase(
      noteRepository:
          NoteRepositoryImp(noteRemoteDataSource: NoteRemoteDataSourceImp()));

  Future<ResponseEntity> updateNotes(NoteDataEntity noteDataEntity) async {
    return _noteUseCase.updateNotesUseCase(noteDataEntity);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  void onUpdateNotes(NoteDataEntity noteDataEntity) {
    updateNotes(noteDataEntity).then((value) {
      if(mounted){
        if (value.error == null && value.data != null) {
          _view.showSuccess(value.message!);
        } else {
          _view.showWarning(value.message!);
        }
        return value;
      }
    });
  }
}
