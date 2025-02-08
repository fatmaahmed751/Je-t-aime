import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Models/product_details_model.dart";
import "package:je_t_aime/Modules/RateProducts/rate_product_data_handler.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../Models/review_model.dart";
import "../../Utilities/router_config.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";

class RateProductController extends ControllerMVC {
  // singleton
  factory RateProductController() {
    _this ??= RateProductController._();
    return _this!;
  }

  static RateProductController? _this;

  RateProductController._();
  bool loading = false;
  bool autoValidate = false;
  late TextEditingController messageController = TextEditingController();
  double productRating = 0.0;
  ReviewModel? reviewModel;
  PopularProductsModel? product;
  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  postRatedSuccessfully(
      {required ProductDetailsModel product, required BuildContext context}) async {
    print("🔍 Debug: Product ID Before API Call: ${product.id}");

    if (product.id == null || product.id == 0) {
      print("⚠️ Error: Product ID is null or 0!");
      ToastHelper.showError(message: "Invalid Product ID");
      return;
    }

    setState(() {
      loading = true;
    });
    print("Product ID: ${product.id}");

    final result = await RateProductDataHandler.rateProduct(
        productId: product.id ?? 0,
        rate: productRating.toInt(),
        comment: messageController.text);
    result.fold((l) {
      setState(() {
        loading = false;
      });
      print("Sending rating for Product ID: ${product.id}");

      ToastHelper.showError(message: l.errorModel.statusMessage);
    }, (r) async {
      ToastHelper.showSuccess(
        backgroundColor: ThemeClass.of(context).primaryColor,
        icon: SvgPicture.asset(Assets.imagesSubmit,
            width: 60.w, height: 50.h, fit: BoxFit.cover),
        message: Strings.rated.tr,
        context: context,
      );
      context.pop();
      setState(() {
        loading = false;
      });
    });
  }
}
