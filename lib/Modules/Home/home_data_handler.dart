import 'package:dartz/dartz.dart';
import 'package:je_t_aime/Models/category_model.dart';

import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class HomeDataHandler{
  static Future<Either<Failure, List<CategoryModel>>> getHomeCategories() async {
    try {
      List<CategoryModel> response = await GenericRequest<CategoryModel>(
        method: RequestApi.get(
            url: APIEndPoint.category,
           ),
        fromMap:CategoryModel.fromJson,
      ).getList();
      print("heeeeeeeeeeeeeeeeel");
      return Right(response);
    } on ServerException catch (failure) {
      print(failure.toString().toString());
      print("heeeeeeeeeeeeeeeeeljjjjjjjj");
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }


}