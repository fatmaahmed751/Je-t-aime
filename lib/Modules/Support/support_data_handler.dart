
import 'package:dartz/dartz.dart';
import '../../../core/API/generic_request.dart';
import '../../../core/error/failures.dart';
import '../../../Utilities/api_end_point.dart';
import '../../../core/API/request_method.dart';
import '../../../core/error/exceptions.dart';

class SupportDataHandler{
  static Future<Either<Failure,String>> support({
    required String email,
    required String phone,
    required String name,
    required String problem,
  })async{
    try {
      var response = await GenericRequest<String>(
          method: RequestApi.post(url: APIEndPoint.support,
            body: {
              "problem":problem,
              "email":email,
              "phone":phone,
              "name":name

            },
          ),
          fromMap:(_)=>_['message']
      ).getResponse();

      print('Raw API Response: $response');
      return Right(response);

    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}