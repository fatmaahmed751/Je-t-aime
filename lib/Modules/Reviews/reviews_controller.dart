import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Modules/Reviews/reviews_data_handler.dart";
import 'package:mvc_pattern/mvc_pattern.dart';
import "../../Models/product_details_model.dart";
import "../../Models/review_model.dart";
import "../../Utilities/router_config.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../RateProducts/rate_product_data_handler.dart";
import "../RateProducts/rate_product_screen.dart";

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
  ProductDetailsModel? productDetailsModel;
  static const pageSize = 10;
  PagingController<int, ReviewModel>? _pagingController;
  PagingController<int, ReviewModel> get pagingController {
    // Ensure the controller is always initialized
    _pagingController ??= PagingController(firstPageKey: 0);
    return _pagingController!;
  }

  @override
  void initState() {
    super.initState();
    _initPagingController();
  }

  void init(PagingController<int, ReviewModel> pagingController, int productId) {
    _pagingController = pagingController;
    _pagingController!.addPageRequestListener((pageKey) {
      getReviews(pageKey, productId);
    });
    getReviews(_pagingController!.firstPageKey, productId);
  }

  void _initPagingController() {
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController!.addPageRequestListener((pageKey) {
      // This will be overridden in the `init` method
    });
  }

  // @override
  // void initState() {
  //   messageController = TextEditingController();
  //   _pagingController.addPageRequestListener((pageKey) {
  //     getReviews(pageKey, model?.id??0);
  //   });
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   messageController.dispose();
  //   super.dispose();
  // }
  //
  // init({required int reviewProductId}) {
  //   if (_pagingController.itemList == null ||
  //       _pagingController.itemList!.isEmpty) {
  //     getReviews(_pagingController.firstPageKey, reviewProductId);
  //   }
  // }
  Future<void> getReviews(int pageKey, int productId) async {
    if (loading) return; // Avoid duplicate calls
    loading = true;
    notifyListeners();

    final newItems = await ReviewsDataHandler.reviewsForProduct(
      pageKey,
      pageSize,
      productId,
    );

    newItems.fold(
          (failure) {
        _pagingController!.error = failure;
      },
          (reviews) {
        final isLastPage = reviews.length < pageSize;
        if (isLastPage) {
          _pagingController!.appendLastPage(reviews);
        } else {
          final nextPageKey = pageKey + reviews.length;
          _pagingController!.appendPage(reviews, nextPageKey);
        }

        loading = false;
        notifyListeners();
      },
    );
  }

  // Future<void> getReviews(int pageKey, int reviewProductId) async {
  //   //try {
  //   final newItems = await ReviewsDataHandler.reviewsForProduct(
  //     pageKey,
  //     pageSize,
  //     reviewProductId,
  //   );
  //   newItems.fold(
  //           (failure) {
  //         _pagingController.error = failure;
  //       },
  //           (reviews) {
  //         final isLastPage = reviews.length < pageSize;
  //         if (isLastPage) {
  //           _pagingController.appendLastPage(reviews);
  //         } else {
  //           final nextPageKey = pageKey + reviews.length;
  //           _pagingController.appendPage(reviews, nextPageKey);
  //         }
  //       }
  //   );
  //
  // }

  Future writeRateForProduct(BuildContext context,int productId) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) =>  RateProductScreen(
          productId:productId
      ),
    );
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

