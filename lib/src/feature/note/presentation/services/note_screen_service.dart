import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/note_data_source.dart';
import '../../data/repositories/note_repository_imp.dart';
import '../../domain/entities/note_data_entity.dart';
import '../../domain/use_cases/note_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void onNavigateToNoteDetailsScreen(NoteDataEntity noteDataEntity);
}

mixin NoteScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final NoteUseCase _noteUseCase = NoteUseCase(
      noteRepository:
          NoteRepositoryImp(noteRemoteDataSource: NoteRemoteDataSourceImp()));

  Future<ResponseEntity> getNoteList() async {
    return _noteUseCase.getNotesUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadNotesData();
  }

  @override
  void dispose() {
    noteDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<NoteDataEntity>> noteDataStreamController =
      AppStreamController();

  ///Load Category list
  void _loadNotesData() {
    if (!mounted) return;
    noteDataStreamController.add(LoadingState());
    getNoteList().then((value) {
      if (value.error == null && value.data.noteDataEntity!.isNotEmpty) {
        noteDataStreamController.add(
            DataLoadedState<List<NoteDataEntity>>(value.data!.noteDataEntity));
      } else if (value.error == null && value.data.noteDataEntity!.isEmpty) {
        noteDataStreamController.add(EmptyState(message: 'No Notes Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///OnTap Note
  void onTapNote(NoteDataEntity noteDataEntity) {
    _view.onNavigateToNoteDetailsScreen(noteDataEntity);
  }
}
