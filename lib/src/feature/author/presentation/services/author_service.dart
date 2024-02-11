import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../data/data_sources/remote/author_data_source.dart';
import '../../data/repositories/author_repository_imp.dart';
import '../../domain/use_cases/author_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/author_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToAuthorDetailsScreen();
}

mixin AuthorService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AuthorUseCase _authorUseCase = AuthorUseCase(
      authorRepository: AuthorRepositoryImp(
          authorRemoteDataSource: AuthorRemoteDataSourceImp()));

  Future<ResponseEntity> getAuthors() async {
    return _authorUseCase.getAuthorsUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadAuthorData();
  }

  @override
  void dispose() {
    authorDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<AuthorDataEntity>> authorDataStreamController =
      AppStreamController();

  ///Load Auth list
  void _loadAuthorData() {
    if (!mounted) return;
    authorDataStreamController.add(LoadingState());
    getAuthors().then((value) {
      if (value.error == null && value.data.authorDataEntity.isNotEmpty) {
        authorDataStreamController.add(DataLoadedState<List<AuthorDataEntity>>(
            value.data.authorDataEntity));
      } else if (value.error == null && value.data.authorDataEntity.isEmpty) {
        authorDataStreamController.add(EmptyState(message: 'No Author Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///On Tap Author
  void onTapAuthor() {
    _view.navigateToAuthorDetailsScreen();
  }
}
