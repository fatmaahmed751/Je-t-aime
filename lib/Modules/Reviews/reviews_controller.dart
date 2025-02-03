import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Modules/Reviews/reviews_data_handler.dart";
import 'package:mvc_pattern/mvc_pattern.dart';
import "package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart";
import "../../Models/generic_pagination_model.dart";
import "../../Models/review_model.dart";
import "../../Utilities/router_config.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../RateProducts/rate_product_data_handler.dart";
import '../RateProducts/rate_product_screen.dart';

class ReviewsForProductController extends ControllerMVC {
  // singleton
  factory ReviewsForProductController() {
    _this ??= ReviewsForProductController._();
    return _this!;
  }

  static ReviewsForProductController? _this;

  ReviewsForProductController._();

  bool loading = false,
      autoValidate = false;
  PopularProductsModel? productsModel;
  late TextEditingController messageController = TextEditingController();
  double productRating = 0.0;
  RefreshController reviewsRefreshController = RefreshController(
      initialRefresh: false);
  GenericPaginationModel<ReviewModel> reviews = GenericPaginationModel<
      ReviewModel>();

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

  init({required PopularProductsModel product}) {
    reviews = GenericPaginationModel<ReviewModel>();
    reviewsRefreshController = RefreshController(initialRefresh: false);
    listOfReviewsOfProduct(id: product.id ?? 0);
  }

  Future listOfReviewsOfProduct({bool refresh = false, int? id}) async {
    if (refresh) reviews = GenericPaginationModel<ReviewModel>();
    if (reviews.data.isEmpty) {
      loading = true;
      setState(() {});
    }
    final result = await ReviewsDataHandler.reviewsForProduct(
        oldPagination: reviews, id: id ?? 0);
    result.fold((l) => null, (r) {
      final oldItems = reviews.data;
      reviews = r;
      print("pagination${reviews.data.length}");
      print("real pagination${r.data.length}");
      if (!refresh) reviews.data.insertAll(0, oldItems);
    });
    if (!reviews.hasNextPge) {
      reviewsRefreshController.loadNoData();
    } else {
      reviewsRefreshController.loadComplete();
    }
    if (refresh) reviewsRefreshController.refreshCompleted();
    setState(() {
      loading = false;
    });
  }

  postRatedSuccessfully() async {
    setState(() {
      loading = true;
    });
    final result = await RateProductDataHandler.rateProduct(
        productId: productsModel?.id ?? 0,
        rate: productRating.toInt(),
        comment: messageController.text);
    result.fold((l) {
      setState(() {
        loading = false;
      });
      ToastHelper.showError(message: l.errorModel.statusMessage);
    }, (r) async {
      ToastHelper.showSuccess(
          backgroundColor: ThemeClass
              .of(currentContext_!)
              .primaryColor,
          icon: SvgPicture.asset(Assets.imagesSubmit, width: 60.w,
            height: 50.h,
            fit: BoxFit.cover,),
          message: "gooood", context: currentContext_!);
      currentContext_!.pop();
    });
    setState(() {
      loading = false;
    });
  }
}
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

