
import "package:dartz/dartz.dart";

import "../../Models/generic_pagination_model.dart";
import "../../Models/review_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class ReviewsDataHandler {
  static Future<
      Either<Failure, GenericPaginationModel<ReviewModel>>> reviewsForProduct(
      {required GenericPaginationModel oldPagination, required int id}) async {
    try {
      Map<String, dynamic> body = {};
      body.addAll(oldPagination.nextData);
      GenericPaginationModel<ReviewModel> response = await GenericRequest <
          GenericPaginationModel<ReviewModel>>(
        method: RequestApi.postJson(
          url: APIEndPoint.getReviews(id), bodyJson: body,),
        fromMap: (_) =>
            GenericPaginationModel.fromJson(_, fromJson: ReviewModel.fromJson),
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}