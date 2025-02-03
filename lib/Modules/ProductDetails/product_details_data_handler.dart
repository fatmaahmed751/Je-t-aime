
import "package:dartz/dartz.dart";
import "package:je_t_aime/Models/product_details_model.dart";

import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class ProductDetailsDataHandler{
  static Future<Either<Failure,ProductDetailsModel>> getProductDetails({required int id}) async {
    try {
      ProductDetailsModel response = await GenericRequest<ProductDetailsModel>(
        method: RequestApi.get(url: APIEndPoint.getProductDetails(id)),
        fromMap: ProductDetailsModel.fromJson,
      ).getObject();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }

  }

}