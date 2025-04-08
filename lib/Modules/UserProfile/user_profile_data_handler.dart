import "package:dartz/dartz.dart";

import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class UserProfileDataHandler{
  static Future<Either<Failure,String>> userLogOut()async{
    try {
      var response = await GenericRequest<String>(
        method: RequestApi.post(url: APIEndPoint.logOut,
            body: {}
        ),
        fromMap:(_)=>_['message'],
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
  static Future<Either<Failure,String>> deleteAccount()async{
    try {
      var response = await GenericRequest<String>(
        method: RequestApi.post(url: APIEndPoint.deleteAccount,
            body: {}
        ),
        fromMap:(_)=>_['message'],
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
