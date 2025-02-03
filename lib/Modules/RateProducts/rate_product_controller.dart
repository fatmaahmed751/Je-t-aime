import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Models/popular_products_model.dart';
import 'package:je_t_aime/Modules/RateProducts/rate_product_data_handler.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/router_config.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/toast_helper.dart';
import '../../generated/assets.dart';

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

  postRatedSuccessfully() async {
    setState(() {
      loading = true;
    });
    final result = await RateProductDataHandler.rateProduct(
        productId: product?.id ?? 0,
        rate: productRating.toString(),
        comment: messageController.text);
    result.fold((l) {
      setState(() {
        loading = false;
      });
      ToastHelper.showError(message: l.errorModel.statusMessage);
    }, (r) async {
      // ToastHelper.showSuccess(
      //     backgroundColor:ThemeClass.of(currentContext_!).primaryColor,
      //   icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
      //     height:50.h,
      //     fit: BoxFit.cover,),
      //     message:"", context: currentContext_!);
      currentContext_!.pop();
    });
    setState(() {
      loading = false;
    });
  }
}
