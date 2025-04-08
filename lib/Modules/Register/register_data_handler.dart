import 'package:dartz/dartz.dart';
import "package:firebase_messaging/firebase_messaging.dart";

import '../../Models/user_model.dart';
import '../../Utilities/api_end_point.dart';
import "../../Widgets/location_services.dart";
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class RegisterDataHandler {
  static Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      String? fcm = await FirebaseMessaging.instance.getToken();
      print("$fcm");
      print("******************************************************");
      String? locationText = await LocationService().getCurrentLocationAndAddress();
      print("User location: $locationText");
      UserModel response = await GenericRequest<UserModel>(
        method: RequestApi.post(url: APIEndPoint.register, body: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": password,
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
