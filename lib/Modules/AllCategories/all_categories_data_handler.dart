
import "package:dartz/dartz.dart";

import "../../Models/category_model.dart";
import "../../Models/generic_pagination_model.dart";
import "../../Models/categories_product_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class AllCategoriesDataHandler {
  static Future<Either<Failure, List<CategoryProductModel>>> getAllCategories(int pageKey, int pageSize,int categoryId) async {
    try {
      List<CategoryProductModel> response = await GenericRequest<CategoryProductModel>(
        method: RequestApi.get(url: "${APIEndPoint.getCategoriesProduct(categoryId)}?page=$pageKey&pageSize=$pageSize"),
        fromMap: CategoryProductModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }

}