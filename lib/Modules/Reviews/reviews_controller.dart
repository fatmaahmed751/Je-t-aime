import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Modules/Reviews/reviews_data_handler.dart";
import 'package:mvc_pattern/mvc_pattern.dart';
import "../../Models/review_model.dart";
import "../../Utilities/router_config.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../RateProducts/rate_product_data_handler.dart";

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
  final bool _isDisposed = false;
  List<ReviewModel>reviews=[];
  PopularProductsModel? model;
  static const pageSize = 10;
  PagingController<int, ReviewModel> get pagingController => _pagingController;

  final PagingController<int, ReviewModel> _pagingController =
  PagingController(firstPageKey: 0);
  @override
  void initState() {
    messageController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      getReviews(pageKey, model?.id??0);
    });
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  init({required int reviewProductId}) {
    if (_pagingController.itemList == null ||
        _pagingController.itemList!.isEmpty) {
      getReviews(_pagingController.firstPageKey, reviewProductId);
    }
  }
  Future<void> getReviews(int pageKey, int reviewProductId) async {
    try {
      final newItems = await ReviewsDataHandler.reviewsForProduct(
        pageKey,
        pageSize,
        reviewProductId,
      );
      if (_isDisposed) return; // Cancel if disposed

      newItems.fold(
            (failure) {
          if (!_isDisposed) { // Check if disposed
            _pagingController.error = failure;
          }
        },
            (categories) {
          if (!_isDisposed) { // Check if disposed
            final isLastPage = reviews.length < pageSize;
            if (isLastPage) {
              _pagingController.appendLastPage(reviews);
            } else {
              final nextPageKey = pageKey + reviews.length;
              _pagingController.appendPage(reviews, nextPageKey);
            }
          }
        },
      );
    } catch (error) {
      if (!_isDisposed) { // Check if disposed
        _pagingController.error = error;
      }
    }
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

