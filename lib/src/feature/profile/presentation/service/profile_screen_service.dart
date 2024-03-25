import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../progress/data/data_sources/remote/progress_data_source.dart';
import '../../../progress/data/repositories/progress_repository_imp.dart';
import '../../../progress/domain/entities/progress_data_entity.dart';
import '../../../progress/domain/use_cases/progress_use_case.dart';
import '../../domain/use_cases/profile_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/profile_data_source.dart';
import '../../data/repositories/profile_repository_imp.dart';
import '../../domain/entities/profile_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToNotificationScreen();
  void navigateToBookReportScreen();
  void navigateToRequestedBookScreen();
  void navigateToReadBookScreen();
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

  final ProgressUseCase _progressUseCase = ProgressUseCase(
      progressRepository: ProgressRepositoryImp(
          progressRemoteDataSource: ProgressRemoteDataSourceImp()));

  Future<ResponseEntity> getProgressCounts() async {
    return _progressUseCase.getProgressCountsUseCase();
  }

  int _selectedTabIndex = 0;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadDataList();
  }

  @override
  void dispose() {
    stateDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<StateType> stateDataStreamController =
      AppStreamController();

  ///Load data list from server based on selected tab
  void _loadDataList() {
    if (!mounted) return;

    ///Loading state
    stateDataStreamController.add(LoadingState<StateType>());
    if (_selectedTabIndex == 0) {
      _loadProfileData();
    } else {
      _loadProgressData();
    }
  }

  ///Load Profile
  void _loadProfileData() {
    // if (!mounted) return;
    // profileDataStreamController.add(LoadingState());
    getProfileInformation().then((value) {
      if (_selectedTabIndex != 0) return;
      if (value.error == null && value.data != null) {
        stateDataStreamController
            .add(DataLoadedState<StateType>(ProfileDataState(value.data)));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///Load Progress data
  void _loadProgressData() {
    // if (!mounted) return;
    // profileDataStreamController.add(LoadingState());
    getProgressCounts().then((value) {
      if (_selectedTabIndex != 1) return;
      if (value.error == null && value.data != null) {
        stateDataStreamController
            .add(DataLoadedState<StateType>(ProgressDataState(value.data)));
      } else if (value.error == null && value.data == null) {
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTabValueChange(int value) {
    _selectedTabIndex = value;
    _loadDataList();
  }

  void onTapNotification() {
    _view.navigateToNotificationScreen();
  }

  void onTapBookReport() {
    _view.navigateToBookReportScreen();
  }

  void onTapRequestedBook() {
    _view.navigateToRequestedBookScreen();
  }

  void onTapReadBook() {
    _view.navigateToReadBookScreen();
  }
}

abstract class StateType {}

class ProfileDataState extends StateType {
  final ProfileDataEntity profileDataEntity;
  ProfileDataState(this.profileDataEntity);
}

class ProgressDataState extends StateType {
  final ProgressDataEntity progressDataEntity;
  ProgressDataState(this.progressDataEntity);
}
