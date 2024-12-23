// import 'package:dartz/dartz.dart';
// import '../../../Utilities/api_end_point.dart';
// import '../../../core/API/generic_request.dart';
// import '../../../core/API/request_method.dart';
// import '../../../core/error/exceptions.dart';
// import '../../../core/error/failures.dart';
//
// class OTPCodeDataHandler {
//   static Future<Either<Failure, String>> verificationCodeResetPassword({
//    required String email,
//     required String code,
//   }) async {
//     try {
//       var response = await GenericRequest<String>(
//         method: RequestApi.post(
//           url: APIEndPoint.forgetPassword,
//           body: {
//            "email": email,
//             "code": code,
//           },
//         ),
//         fromMap : (_) => _["message"],
//       ).getResponse();
//
//       return Right(response);
//     } on ServerException catch (failure) {
//       return Left((ServerFailure(failure.errorMessageModel)));
//     }
//   }
// }
//
//
