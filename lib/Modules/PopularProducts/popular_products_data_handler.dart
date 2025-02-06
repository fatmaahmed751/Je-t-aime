import "package:dartz/dartz.dart";
import "package:je_t_aime/Models/popular_products_model.dart";

import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class PopularProductsDataHandler {
  static Future<Either<Failure, String>> addFavorite({required int productId}) async {
    try {
      String response = await GenericRequest<String>(
        method: RequestApi.post(url: APIEndPoint.addFavorite,
            body: {
          "product_id": productId
        }),
        fromMap: (_) => _["message"],

      ).getResponse();
      print('jjjjjjjjjjjjjjjjjjjjjjj');
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
  static Future<Either<Failure, List<PopularProductsModel>>> getAllPopularProducts(
      int pageKey,
      int pageSize,
    ) async {
    try {

      List<PopularProductsModel> response = await GenericRequest <PopularProductsModel>(
        method: RequestApi.get(
            url: "${APIEndPoint.getPopularProduct}?page=$pageKey&pageSize=$pageSize"
        ),
        fromMap: PopularProductsModel.fromJson,

      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}