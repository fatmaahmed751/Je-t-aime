
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../RateProducts/rate_product_screen.dart';
class ReviewsForProductController extends ControllerMVC {
  // singleton
  factory ReviewsForProductController() {
    _this ??= ReviewsForProductController._();
    return _this!;
  }
  static ReviewsForProductController? _this;
  ReviewsForProductController._();
  bool loading=false,autoValidate = false;
  late TextEditingController writeReviewController =TextEditingController();

  dynamic image;
  @override
  void initState() {
    writeReviewController =TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    writeReviewController.dispose();
    super.dispose();
  }

  Future writeRateForProduct(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder:(context)=> const RateProductScreen(),
    );
  }
// listOfReviewsOfProduct()async{
//     loading=true;
//     setState((){}
//     );
//     final result = await ReviewsDataHandler.reviewsForProduct();
//     result.fold((l) {
//       ToastHelper.showError(message: l.errorModel.statusMessage);
//     }, (r)async {
//         reviews = r;
//       print("reviewsss${reviews}");
//
//     });
//     setState((){
//       loading=false;
//     });
//   }



  // unLoginForRatedPop(BuildContext ctx) {
  //   DialogHelper.custom(context: ctx).customDialog(
  //       dialogWidget: UnLoginForRatedWidget(
  //         des: Strings.hintForUserReview.tr,
  //         onButtonAccept: () {
  //           GoRouter.of(currentContext_!).pushNamed(RegisterScreen.routeName);
  //           ctx.pop();
  //         },
  //         onButtonReject: () {
  //           ctx.pop();
  //         },
  //         // titleButtonAccept: Strings.yes.tr,
  //         // titleButtonReject: Strings.cancel.tr,
  //       ),
  //       dismiss: false);
  // }

}
