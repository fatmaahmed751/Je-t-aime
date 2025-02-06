import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
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
import "../Reviews/reviews_data_handler.dart";
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
  static const pageSize = 2;
  PagingController<int, ReviewModel> get pagingController => _pagingController;

  final PagingController<int, ReviewModel> _pagingController =
  PagingController(firstPageKey: 0);
  @override
  void initState() {
    messageController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
  Future<void> fetchPage(int pageKey) async {
    try {
      // Fetch data from your API or data source
      final newItems = await fetchReviews(pageKey);

      final isLastPage = newItems.length < 10; // Adjust based on your API's pagination logic
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<ReviewModel>> fetchReviews(int pageKey) async {
    // Replace this with your actual API call
    final response = await ReviewsDataHandler.reviewsForProduct(
          pageKey,
          pageSize,
          productDetailsModel?.id??0,

    );
    return [];
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
      print("Product Details: ${productDetailsModel?.toJson()}");
      print("Reviews: ${productDetailsModel?.reviews?.toJson()}");

    });
    setState(() {loading=false;});
  }
}
