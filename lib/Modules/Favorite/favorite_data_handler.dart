import "package:dartz/dartz.dart";
import "../../Models/popular_products_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class FavoritesDataHandler {
  static Future<Either<Failure, List<PopularProductsModel>>> favoritesProduct(
      int pageKey,
      int pageSize,
     ) async {
    try {

      List<PopularProductsModel> response = await GenericRequest <PopularProductsModel>(
        method: RequestApi.get(
            url: "${APIEndPoint.getFavorites}?page=$pageKey&pageSize=$pageSize"
        ),
        fromMap: PopularProductsModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}