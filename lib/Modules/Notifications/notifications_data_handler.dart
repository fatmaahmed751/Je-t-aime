import "package:dartz/dartz.dart";

import "../../Models/notification_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class NotificationsDataHandler{
  static Future<Either<Failure, List<NotificationModel>>> listOfAllNotifications(
      int pageKey,
      int pageSize,) async {
    try {
      List<NotificationModel> response = await GenericRequest <NotificationModel>(
        method: RequestApi.get(
            url: APIEndPoint.allNotifications
        ),
        fromMap: NotificationModel.fromJson,
      ).getList();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }


  static Future<Either<Failure,String>> readNotification({
    required String notificationId
  })async{
    try {
      var response = await GenericRequest<String>(
          method: RequestApi.get(
              url: APIEndPoint.readNotification(notificationId)),
          fromMap:(_)=>_['message']
      ).getResponse();
      print('Raw API Response: $response*/////////////////////////////////////////');
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
