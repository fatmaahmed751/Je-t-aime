import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Models/product_details_model.dart";
import "package:je_t_aime/Models/review_model.dart";
import "package:je_t_aime/Modules/ProductDetails/product_details_data_handler.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../Utilities/router_config.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../RateProducts/rate_product_data_handler.dart";
import "../RateProducts/rate_product_screen.dart";
import "Widgets/add_to_cart_bottom_sheet.dart";

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
  bool isExpanded = false;
  PopularProductsModel? product;
  int activeIndex = 0;
  bool isSearch = false;
  bool loading = false;
  late TextEditingController messageController = TextEditingController();
  double productRating = 0.0;
  ProductDetailsModel? productDetailsModel;

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

  onPageChange(int index) {
    setState(() {
      activeIndex = index;
    });
    activeIndex = index;
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
      builder: (context) =>  RateProductScreen(
        productId:product?.id??0
      ),
    );
  }
  postRatedSuccessfully() async {
    print("🔍 Debug: Product ID Before API Call: ${product?.id}");

    if (product?.id == null || product?.id == 0) {
      print("⚠️ Error: Product ID is null or 0!");
      ToastHelper.showError(message: "Invalid Product ID");
      return;
    }

    setState(() {
      loading = true;
    });
    print("Product ID: ${product?.id}");

    final result = await RateProductDataHandler.rateProduct(
        productId: product!.id!,
        rate: productRating.toInt(),
        comment: messageController.text);
    result.fold((l) {
      setState(() {
        loading = false;
      });
      print("Sending rating for Product ID: ${product?.id}");

      ToastHelper.showError(message: l.errorModel.statusMessage);
    }, (r) async {
      ToastHelper.showSuccess(
          backgroundColor:ThemeClass.of(currentContext_!).primaryColor,
          icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
            height:50.h,
            fit: BoxFit.cover,),
          message:"gooood", context: currentContext_!);
      currentContext_!.pop();
    });
    setState(() {
      loading = false;
    });
  }
  Future addToCartSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) => const AddToCartBottomSheetWidget(),
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
  Future getProductDetails({required int productId}) async {
    loading=true;
    setState(() { });
    final result = await ProductDetailsDataHandler.getProductDetails(id: productId);
    result.fold((l){
      ToastHelper.showError(message: l.toString());
      print("product error ${l.errorModel.statusMessage.toString()}");
    },(r) {
      productDetailsModel=r;
      print("product reviews${productDetailsModel?.reviews??ReviewModel()}");

    });
    setState(() {loading=false;});
  }
}
