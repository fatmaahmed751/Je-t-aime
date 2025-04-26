import "package:dartz/dartz.dart";
import "../../Models/favorite_model.dart";
import "../../Models/popular_products_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class FavoritesDataHandler {
  static Future<Either<Failure, List<FavoriteModel>>> favoritesProduct(
      int pageKey,
      int pageSize,
     ) async {
    try {

      List<FavoriteModel> response = await GenericRequest <FavoriteModel>(
        method: RequestApi.get(
            url:APIEndPoint.getFavorites
           // "${APIEndPoint.getFavorites}?page=$pageKey&pageSize=$pageSize"
        ),
        fromMap: FavoriteModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}