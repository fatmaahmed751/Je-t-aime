import 'package:flutter/cupertino.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/core/Language/locales.dart";
import 'package:mvc_pattern/mvc_pattern.dart';

import "../../Models/categories_product_model.dart";
import "../../Models/favorite_model.dart";
import "../../Models/popular_products_model.dart";
import "../../Utilities/shared_preferences.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../Cart/cart_data_handler.dart";
import "favorite_data_handler.dart";

class FavoriteController extends ControllerMVC {
  // singleton
  factory FavoriteController() {
    _this ??= FavoriteController._();
    return _this!;
  }

  static FavoriteController? _this;
  bool isUserHaveFavorites = false;
  FavoriteController._();
  bool loading = false;
  bool isLiked = false;
  bool isLogin = false;
  late TextEditingController searchController;
  List<FavoriteModel> products=[];
  FavoriteModel? model;
  static const pageSize = 10;
  int quyCount = 1;
  PagingController<int, FavoriteModel> get pagingController => _pagingController;

  final PagingController<int, FavoriteModel> _pagingController =
  PagingController(firstPageKey: 0);
  @override
  void initState() {
    searchController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      getFavorites(pageKey);
    });
    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.firstPageError) {
        print("Error occurred while fetching favorites.");
      }
    });
    // _pagingController.addPageRequestListener((pageKey) {
    //   getFavorites(pageKey);
    // });
    super.initState();
  }
  init() {
    if (_pagingController.itemList == null ||
        _pagingController.itemList!.isEmpty) {
      getFavorites(_pagingController.firstPageKey);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  Future<void> getFavorites(int pageKey) async {
    //try {
    final newItems = await FavoritesDataHandler.favoritesProduct(
      pageKey,
      pageSize,
    );
    newItems.fold(
            (failure) {
          _pagingController.error = failure;
        },
            (products) {
          final isLastPage = products.length < pageSize;
          print("${products.length}");
          if (isLastPage) {
            _pagingController.appendLastPage(products);
          } else {
            final nextPageKey = pageKey + products.length;
            _pagingController.appendPage(products, nextPageKey);
          }
        }
    );

  }
  Future<bool> isProductInCart(int productId) async {
    final cartProducts = await SharedPref.getCart();
    return cartProducts.any((cartProduct) => cartProduct.id == productId);
  }
  addProductToCart({
    required BuildContext context, required FavoriteModel model})
  async {
    setState(() {
      loading = true;
    });
    print("Product ID: ${model.id}, Quantity: $quyCount");
    final result = await CartDataHandler.addToCart(
        productId: model.id ?? 0,
        quantity: quyCount);
    result.fold((l) {
      ToastHelper.showError(message: l.toString());
    }, (r)async {
      print("adddddddddddd");
      ToastHelper.showSuccess(
        context: context,
        message: Strings.addToCartSuccess.tr,
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor: ThemeClass.of(context).primaryColor,
      );
      setState(() {
        loading = false;
      });
    });

  }

}
