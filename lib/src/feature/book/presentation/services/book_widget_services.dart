import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../bookmark/data/data_sources/remote/bookmark_data_source.dart';
import '../../../bookmark/data/repositories/bookmark_repository_imp.dart';
import '../../../bookmark/domain/use_cases/book_mark_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/book_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin BookmarkWidgetService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final BookmarkUseCase _bookmarkUseCase = BookmarkUseCase(
      bookmarkRepository: BookmarkRepositoryImp(
          bookmarkRemoteDataSource: BookmarkRemoteDataSourceImp()));

  Future<ResponseEntity> bookmarkBookAction(
      {required int bookId, required int eMISUserId}) async {
    return _bookmarkUseCase.bookmarkUseCase(bookId, eMISUserId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Stream controllers
  final StreamController<bool> bookMarkIconController =
      StreamController<bool>();

  void onBookmarkContentSelected(BookDataEntity item) {
    bookmarkBookAction(
      bookId: item.id,
      eMISUserId: 1,
    ).then((value) {
      if (value.error == null && value.data != null) {
        bookMarkIconController.sink.add(!item.bookMark);
        _view.showSuccess(item.bookMark
            ? "বুকমার্ক সফলভাবে যোগ করা হয়েছে !"
            : "বুকমার্ক সফলভাবে মুছে ফেলা হয়েছে !");
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
