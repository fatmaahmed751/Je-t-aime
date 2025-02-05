import "package:dartz/dartz.dart";
import "../../../core/API/generic_request.dart";
import "../../../core/error/failures.dart";
import "../../../Utilities/api_end_point.dart";
import "../../../core/API/request_method.dart";
import "../../../core/error/exceptions.dart";
import "../../Utilities/shared_preferences.dart";

class RateProductDataHandler {
  static Future<Either<Failure, String>> rateProduct({
    required int productId,
    required int rate,
    required String comment,
  }) async {
    try {
      String? token = SharedPref.getCurrentUser()?.token; // Get saved token

      if (token == null || token.isEmpty) {
        print("⚠️ Error: Missing Authentication Token");
      }

      print("🛠 Using Token: $token"); // Debug token before request

      var response = await GenericRequest<String>(
          method: RequestApi.post(
            url: APIEndPoint.postReview,
            headers: {
              "Authorization": "Bearer $token", // ✅ Correct header format
              "Content-Type": "application/json",
            },
            body: {
              "product_id": productId,
              "rate": rate,
              "message": comment,
            },
          ),
          fromMap: (_) => _["message"])
          .getResponse();

      print("Raw API Response: $response");
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
