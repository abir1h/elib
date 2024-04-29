import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/paginated_list_view.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/note_data_source.dart';
import '../../data/repositories/note_repository_imp.dart';
import '../../domain/entities/note_data_entity.dart';
import '../../domain/use_cases/note_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void onNavigateToNoteDetailsScreen(NoteDataEntity noteDataEntity);
}

mixin NoteScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final NoteUseCase _noteUseCase = NoteUseCase(
      noteRepository:
          NoteRepositoryImp(noteRemoteDataSource: NoteRemoteDataSourceImp()));

  Future<ResponseEntity> getNoteList(bool enablePagination,
      {int? pageNumber}) async {
    return _noteUseCase.getNotesUseCase(enablePagination,
        pageNumber: pageNumber);
  }

  Future<ResponseEntity> deleteNotes({required int noteId}) async {
    return _noteUseCase.deleteNotesUseCase(noteId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    loadNotesData(true, pageNumber: 1);
    paginationController.onLoadMore = _onLoadMoreItems;
  }

  @override
  void dispose() {
    // noteDataStreamController.dispose();
    pageStateStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  // final AppStreamController<List<NoteDataEntity>> noteDataStreamController =
  //     AppStreamController();

  ///Stream controllers
  final AppStreamController<PaginatedListViewController<NoteDataEntity>> pageStateStreamController = AppStreamController();
  PaginatedListViewController<NoteDataEntity> paginationController = PaginatedListViewController();

  ///Load Category list
  void loadNotesData(bool enablePagination, {int? pageNumber}) {
    if(!mounted) return;
    paginationController.clear();
    pageStateStreamController.add(LoadingState());
    getNoteList(enablePagination, pageNumber: pageNumber).then((value) {
      if (value.error == null && value.data.noteDataEntity!.isNotEmpty) {
        // noteDataStreamController.add(
        //     DataLoadedState<List<NoteDataEntity>>(value.data!.noteDataEntity));
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.noteDataEntity);
        pageStateStreamController.add(DataLoadedState(paginationController));

      } else if (value.error == null && value.data.noteDataEntity!.isEmpty) {
        pageStateStreamController.add(EmptyState(message: 'No Notes Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///OnTap Note
  void onTapNote(NoteDataEntity noteDataEntity) {
    _view.onNavigateToNoteDetailsScreen(noteDataEntity);
  }

  Future<ResponseEntity> onNotesDelete(int noteId) async {
    CustomToasty.of(context).lockUI();
    ResponseEntity responseEntity = await deleteNotes(noteId: noteId);
    if (responseEntity.error == null && responseEntity.data != null) {
      loadNotesData(true, pageNumber: 1);
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    CustomToasty.of(context).releaseUI();
    return responseEntity;
  }

  ///Load more data
  Future<bool> _onLoadMoreItems(int nextPage) async{
    Completer<bool> completer = Completer();
    getNoteList(true, pageNumber: nextPage).asStream().listen((value) {
      if (!mounted) return;
      ///Data loaded state
      if(value.error == null && value.data.noteDataEntity.isNotEmpty){
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.noteDataEntity);
        completer.complete(true);
      }
      ///Error state
      else{
        ///Try reloading
        // _view.showWarning(value.message);
        completer.complete(false);
      }
    });

    return completer.future;
  }

}
