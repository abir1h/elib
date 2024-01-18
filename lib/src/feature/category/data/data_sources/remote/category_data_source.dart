import '../../../../shared/data/models/response_model.dart';

abstract class CategoryRemoteDataSource {
  Future<ResponseModel> getCategoriesAction();
}

class CategoryRemoteDataSourceImp extends CategoryRemoteDataSource {

  @override
  Future<ResponseModel> getCategoriesAction() async{
    throw UnimplementedError();
  }



}