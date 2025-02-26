import "package:dartz/dartz.dart";
import "package:je_t_aime/Models/shipping_model.dart";
import "../../Models/cart_item_model.dart";
import "../../Utilities/api_end_point.dart";
import "../../core/API/generic_request.dart";
import "../../core/API/request_method.dart";
import "../../core/error/exceptions.dart";
import "../../core/error/failures.dart";

class ShippingDataHandler{
  static Future<Either<Failure, String>> shippingForOrder({
     required List<CartModel>items,
        required String name,
        required String phone,
        required String address,
    required int totalPrice
      }) async {
    try {
      Map<String, dynamic> body = {
        "name": name,
        "totalPrice":totalPrice,
        "phone": phone,
        "address": address,
      };
      if (items.isNotEmpty && items != []) {
        for (var product in items) {
          body["items[${items.indexOf(product)}][id]"] = product.id.toString();
          body["items[${items.indexOf(product)}][qty]"] = product.count.toString();
          body["items[${items.indexOf(product)}][price]"] = product.price.toString();
        }
      }
      String response = await GenericRequest<String>(
        method: RequestApi.post(url: APIEndPoint.shippingForOrder, body: body),
        fromMap: (_) => _["message"],
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}

