import 'package:flutter/material.dart';

import '../../../book/domain/entities/book_data_entity.dart';
import '../../domain/entities/note_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void onNavigateToNoteEditScreen(NoteDataEntity noteDataEntity);
  void onNavigateToBookDetailsScreen(BookDataEntity bookDataEntity);
}

mixin NoteDetailsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  void onTapEdit(NoteDataEntity noteDataEntity) {
    _view.onNavigateToNoteEditScreen(noteDataEntity);
  }

  void onTapBookName(BookDataEntity bookDataEntity) {
    _view.onNavigateToBookDetailsScreen(bookDataEntity);
  }
}
