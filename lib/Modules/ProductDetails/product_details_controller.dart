import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/dialog_helper.dart';
import '../../Utilities/router_config.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_bottom_sheet_widget.dart';
import '../../generated/assets.dart';
import '../RateProducts/rate_product_screen.dart';
import 'Widgets/add_to_cart_bottom_sheet.dart';

class ProductDetailsController extends ControllerMVC {
  // singleton
  factory ProductDetailsController() {
    _this ??= ProductDetailsController._();
    return _this!;
  }

  int counter = 1;
  static ProductDetailsController? _this;
  bool isClick = false;
  ProductDetailsController._();
  List list=[1,2,3,4,5];
  List imageUrl=[
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1bJeWtv-CEwrlzO09wgwE3sDUETLh5ZOzg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1bJeWtv-CEwrlzO09wgwE3sDUETLh5ZOzg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1bJeWtv-CEwrlzO09wgwE3sDUETLh5ZOzg&s",
  ];
  bool isExpanded = false;
  int activeIndex=0;
  bool isSearch=false;
  bool loading=false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  onPageChange(int index)
  {
    setState(() {activeIndex=index; });
    activeIndex=index;
  }
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 1) {
        counter--;
      }
    });
  }
  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
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
  Future addToCartSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder:(context)=>   const AddToCartBottomSheetWidget(),
    );
  }
  // Future addFavorite({required int productId}) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   final result = await PopularProductsDataHandler.addFavorite(
  //       productId:productId);
  //   result.fold((l) {
  //     ToastHelper.showError(message: l.errorModel.statusMessage);
  //   }, (r) {
  //     ToastHelper.showSuccess(message: r);
  //
  //   });
  //   setState(() {
  //     loading = false;
  //   });
  // }
  // Future deleteFavorite({required int productId}) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   final result = await PopularProductsDataHandler.deleteFavorite(
  //       productId:productId);
  //   result.fold((l) {
  //     ToastHelper.showError(message: l.errorModel.statusMessage);
  //   }, (r) {
  //     ToastHelper.showSuccess(message: r);
  //
  //   });
  //   setState(() {
  //     loading = false;
  //   });
  // }
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
  //
}