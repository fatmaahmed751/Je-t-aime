import "package:dartz/dartz.dart";

import "../../Models/order_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class ShowOrderDataHandler {
  static Future<Either<Failure, OrderModel>> showOrderDetails({
    required int orderId,
  }) async {
    try {
      OrderModel response = await GenericRequest <OrderModel>(
        method: RequestApi.get(
            url: APIEndPoint.showOrder(orderId)
        ),
        fromMap: OrderModel.fromJson,
      ).getObject();
      print("API Response: ${response.toString()}");
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}