import "package:dartz/dartz.dart";

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
}