import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';

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
  late TextEditingController commentController = TextEditingController();
  double productRating = 0.0;
  @override
  void initState() {
    commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  postRatedSuccessfully() async {
    setState(() {
      loading = true;
    });
    // final result = await RateProductDataHandler.rateProduct(
    //     productId:product?.id.toString()??'',
    //     rate: productRating.toString(),
    //     comment: commentController.text);
    // result.fold((l) {
    //   setState(() {
    //     loading = false;
    //   });
    //   ToastHelper.showError(message: l.errorModel.statusMessage);
    // }, (r) async {
    //   setState(() {
    //     loading = false;
    //   });
    //   showDialog(
    //     context: currentContext_!,
    //     builder: (context) => AlertRateProductSuccessfully(
    //       firstText: Strings.thanksForReview.tr,
    //       secondText: Strings.submitFeedback.tr,
    //     ),
    //   );
    //
    // });
    // setState(() {
    //   loading = false;
    // });
  }


}
