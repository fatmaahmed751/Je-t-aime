import 'package:dartz/dartz.dart';
import '../../../Utilities/api_end_point.dart';
import '../../../core/API/generic_request.dart';
import '../../../core/API/request_method.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';

class ResetPasswordDataHandler{
  static Future<Either<Failure,String>> resetNewPassword({
    required int id,
    required String password,
    required String confirmPassword,

  })async{
    try {
      var response = await GenericRequest<String>(
        method: RequestApi.post(
          url:APIEndPoint.resetPassword,
          body: {
            "user_id": id,
            "new_password": password,
            "password_confirmation": confirmPassword,
          },
        ),
        fromMap : (_) => _["message"],
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
  static Future<Either<Failure, String>> verificationCodeResetPassword({
    required String email,
  }) async {
    try {
      var response = await GenericRequest<String>(
        method: RequestApi.post(
          url: APIEndPoint.resetPassword,
          body: {
            "email": email,
          },
        ),
        fromMap : (_) => _["message"],
      ).getResponse();

      return Right(response);
    } on ServerException catch (failure) {
      return Left((ServerFailure(failure.errorMessageModel)));
    }
  }
}