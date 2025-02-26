
import "package:dartz/dartz.dart";

import "../../Models/cart_item_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../Utilities/shared_preferences.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class CartDataHandler {
  static Future<Either<Failure, String>> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      // String? token = SharedPref.getCurrentUser()?.token; // Get saved token
      //
      // if (token == null || token.isEmpty) {
      //   print("⚠️ Error: Missing Authentication Token");
      // }

     // print("🛠 Using Token: $token"); // Debug token before request

      String response = await GenericRequest<String>(
        method: RequestApi.post(
          body: {"product_id": productId, "qty": quantity},
          url: APIEndPoint.addToCart,
          // headers: {
          //   "Authorization": "Bearer $token", // ✅ Correct header format
          //   "Content-Type": "application/json",
          // },
        ),
        fromMap: (_) => _["message"],
      ).getResponse();
      print("API Response: $response");
      return Right(response);
    } on ServerException catch (failure) {
      print(failure.toString().toString());
      print("heeeeeeeeeeeeeeeeeljjjjjjjj");
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
  static Future<Either<Failure, String>> deleteProduct({
    required int productId,
    required int quantity,
  }) async {
    try {
      String response = await GenericRequest<String>(
        method: RequestApi.post(
          body: {"product_id": productId, "qty": quantity},
          url: APIEndPoint.deleteProductFromCart(productId),
        ),
        fromMap: (_) => _["message"],
      ).getResponse();
      print("API Response: $response");
      return Right(response);
    } on ServerException catch (failure) {
      print(failure.toString().toString());
      print("heeeeeeeeeeeeeeeeeljjjjjjjj");
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }

  static Future<Either<Failure, List<CartModel>>> listOfCartProducts(
  int pageKey,
  int pageSize,
  ) async {
  try {

  List<CartModel> response = await GenericRequest <CartModel>(
  method: RequestApi.get(
  url:APIEndPoint.getCartList
  ),
  fromMap: CartModel.fromJson,
  ).getList();
  return Right(response);
  } on ServerException catch (failure) {
  return Left(ServerFailure(failure.errorMessageModel));
  }
  }

}