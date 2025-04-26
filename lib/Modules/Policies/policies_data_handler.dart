import 'package:dartz/dartz.dart';
import '../../../core/API/generic_request.dart';
import '../../../core/error/failures.dart';
import '../../../Utilities/api_end_point.dart';
import '../../../core/API/request_method.dart';
import '../../../core/error/exceptions.dart';


class PolicesDataHandler{
  static Future<Either<Failure,String>> getPolicies(
      )async{
    try {
      String response = await GenericRequest<String>(
          method: RequestApi.get(url: APIEndPoint.policies
          ),
          fromMap: (_)=> _["message"],
      ).getObject();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
