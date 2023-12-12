// import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
//
// import '../../feature/authentication/data/data_sources/remote/feature_data_source.dart';
// import '../../feature/authentication/data/repositories/feature_repository_imp.dart';
// import '../../feature/authentication/domain/repositories/feature_repository.dart';
// import '../../feature/authentication/domain/use_cases/feature_use_case.dart';
// import '../../feature/authentication/presentation/controllers/authentication_controller.dart';
// import '../config/local_storage_services.dart';
// import '../network/http_client.dart';
//
// GetIt locator = GetIt.instance;
//
// void setup(){
//   Get.lazyPut(() => AuthUseCase(authRepository: locator.get()));
//   Get.lazyPut(() => AuthenticationController(Get.find<AuthUseCase>()));
//
//   locator.registerSingleton(BaseHttpClient());
//   locator.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImp(authRemoteDataSource: AuthRemoteDataSourceImp()),
//   );
// }
//
// initLocalServices() async{
//   await Get.putAsync(() => LocalStorageService.initialize());
// }
