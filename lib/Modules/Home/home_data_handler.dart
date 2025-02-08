import "package:dartz/dartz.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class HomeDataHandler {

  static Future<Either<Failure, Map<String, dynamic>>> getHomeData() async {
    try {
      Map<String, dynamic> response =
          await GenericRequest<Map<String, dynamic>>(
        method: RequestApi.get(url: APIEndPoint.home),
        fromMap: (_) => _,
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
