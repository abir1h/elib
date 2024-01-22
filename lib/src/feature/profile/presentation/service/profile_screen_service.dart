import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../domain/use_cases/profile_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/profile_data_source.dart';
import '../../data/repositories/profile_repository_imp.dart';
import '../../domain/entities/profile_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin ProfileScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final ProfileUseCase _profileUseCase = ProfileUseCase(
      profileRepository: ProfileRepositoryImp(
          profileRemoteDataSource: ProfileRemoteDataSourceImp()));

  Future<ResponseEntity> getProfileInformation() async {
    return _profileUseCase.userProfileInformationUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadCategoryData();
  }

  @override
  void dispose() {
    profileDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<ProfileDataEntity> profileDataStreamController =
      AppStreamController();

  ///Load Category list
  void _loadCategoryData() {
    if (!mounted) return;
    profileDataStreamController.add(LoadingState());
    getProfileInformation().then((value) {
      if (value.error == null && value.data.profileDataEntity!.isNotEmpty) {
        profileDataStreamController.add(
            DataLoadedState<ProfileDataEntity>(value.data!.profileDataEntity));
      } else if (value.error == null && value.data.profileDataEntity!.isEmpty) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
