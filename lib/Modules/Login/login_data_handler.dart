import "../../Widgets/location_services.dart";
import "Package:dartz/dartz.dart";

import "package:firebase_messaging/firebase_messaging.dart";

import "../../Models/user_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class LoginDataHandler {
  static Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
        String? fcm = await FirebaseMessaging.instance.getToken();
        print("$fcm");
        print("******************************************************");

        String? locationText = await LocationService().getCurrentLocationAndAddress();
        print("User location: $locationText");
      UserModel response = await GenericRequest<UserModel>(
        method: RequestApi.post(url: APIEndPoint.login, body: {
          "email": email,
          "password": password,
          "fcm_token":fcm,
          "location": locationText ?? "Unknown Location",
        }),
        fromMap: UserModel.fromJson,
      ).getObject();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
