import 'package:dartz/dartz.dart';

import '../../Models/user_model.dart';
import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class LoginDataHandler {
  static Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      //    String? fcm = await FirebaseMessaging.instance.getToken();
      UserModel response = await GenericRequest<UserModel>(
        method: RequestApi.post(
            url: APIEndPoint.login,
            body: {
              "email": email,
              "password": password,
              // "token":fcm??'',

            }),
        fromMap:UserModel.fromJson,
      ).getObject();
      print("heeeeeeeeeeeeeeeeel");
      return Right(response);
    } on ServerException catch (failure) {
      print(failure.toString().toString());
      print("heeeeeeeeeeeeeeeeeljjjjjjjj");
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
