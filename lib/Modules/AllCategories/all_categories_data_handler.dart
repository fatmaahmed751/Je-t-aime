
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
  static Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      List<CategoryModel> response = await GenericRequest<CategoryModel>(
        method: RequestApi.get(url: APIEndPoint.categories),
        fromMap: CategoryModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
  static Future<Either<Failure, GenericPaginationModel<CategoryProductModel>>> getAllCategoriesProduct(
      {required GenericPaginationModel oldPagination, required int id}
      ) async {
    try {
      Map<String, dynamic> body = {};
      body.addAll(oldPagination.nextData);
      GenericPaginationModel<CategoryProductModel> response = await GenericRequest <
          GenericPaginationModel<CategoryProductModel>>(
        method: RequestApi.postJson(
          url: APIEndPoint.getCategoriesProduct(id), bodyJson: body,),
        fromMap: (_) =>
            GenericPaginationModel.fromJson(_, fromJson: CategoryProductModel.fromJson),
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}