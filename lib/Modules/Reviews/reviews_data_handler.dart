
import "package:dartz/dartz.dart";
import "../../Models/review_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class ReviewsDataHandler {
  static Future<Either<Failure, List<ReviewModel>>> reviewsForProduct(
    int pageKey,
      int pageSize,
     int reviewProductId,) async {
    try {

      List<ReviewModel> response = await GenericRequest <ReviewModel>(
        method: RequestApi.get(
          url: "${APIEndPoint.getReviews(reviewProductId)}?page=$pageKey&pageSize=$pageSize"
        ),
        fromMap: ReviewModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}