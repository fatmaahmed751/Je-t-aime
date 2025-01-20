import 'package:dartz/dartz.dart';

import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class RegisterDataHandler {
  static Future<Either<Failure, String>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      String response = await GenericRequest<String>(
        method: RequestApi.post(url: APIEndPoint.register,
            body: {
          "name":name,
          "email": email,
          "password": password,
          "password_confirmation": password
        }),
        fromMap: (_) => _["message"],
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
