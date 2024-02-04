import 'package:flutter/material.dart';

import '../../../../core/utility/validator.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/book_data_source.dart';
import '../../data/repositories/book_repository_imp.dart';
import '../../domain/entities/book_request_entity.dart';
import '../../domain/use_cases/book_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin BookRequestBottomSheetScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
          BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> createBookRequest(
      {required BookRequestDataEntity bookRequestDataEntity}) async {
    return _bookUseCase.createBookRequestUseCase(bookRequestDataEntity);
  }

  Future<ResponseEntity> updateBookRequest(
      {required BookRequestDataEntity bookRequestDataEntity}) async {
    return _bookUseCase.updateBookRequestUseCase(bookRequestDataEntity);
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

  bool validateFormData(
      TextEditingController authorNameController,
      TextEditingController bookNameController,
      TextEditingController publishYearController,
      TextEditingController editionController) {
    if (Validator.isEmpty(authorNameController.text.trim())) {
      _view.showWarning("Author name is required!");
      return false;
    } else if (!Validator.isValidLength(
        authorNameController.text.trim(), 3, 100)) {
      _view.showWarning("Author name is required at least 3 character!");
      return false;
    } else if (Validator.isValidString(authorNameController.text.trim())) {
      _view.showWarning("Special character is not allowed");
      return false;
    } else if (Validator.isEmpty(bookNameController.text.trim())) {
      _view.showWarning("Book name is required!");
      return false;
    } else if (!Validator.isValidLength(
        bookNameController.text.trim(), 3, 100)) {
      _view.showWarning("Book name is required at least 3 character!");
      return false;
    } else if (Validator.isValidString(bookNameController.text.trim())) {
      _view.showWarning("Special character is not allowed");
      return false;
    } else if (Validator.isEmpty(publishYearController.text.trim())) {
      _view.showWarning("Publish year is required!");
      return false;
    } else if (Validator.isEmpty(editionController.text.trim())) {
      _view.showWarning("Edition is required!");
      return false;
    } else if (!Validator.isValidLength(
        editionController.text.trim(), 3, 100)) {
      _view.showWarning("Edition is required at least 3 character!");
      return false;
    } else {
      return true;
    }
  }

  Future<ResponseEntity> onBookRequestOrUpdate(
      {required BookRequestDataEntity item, required bool edit}) async {
    ResponseEntity responseEntity = edit
        ? await updateBookRequest(bookRequestDataEntity: item)
        : await createBookRequest(bookRequestDataEntity: item);
    if (responseEntity.error == null && responseEntity.data != null) {
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    return responseEntity;
  }
}
