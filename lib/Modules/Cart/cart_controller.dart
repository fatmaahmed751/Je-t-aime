import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Models/cart_item_model.dart";
import "package:je_t_aime/Models/cart_item_model.dart";
import "package:je_t_aime/Modules/Cart/cart_data_handler.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../../Models/user_model.dart";
import "../../Utilities/router_config.dart";
import "../../Utilities/shared_preferences.dart";
import "../../Utilities/strings.dart";
import "alert_delete_item_widget.dart";
class CartController extends ControllerMVC {
  // singleton
  factory CartController() {
    _this ??= CartController._();
    return _this!;
  }

  CartController._();

  bool loading = false;

  String token = "";
  bool isLike = true;

  late TextEditingController couponController;
  static CartController? _this;
  static const pageSize = 10;

  PagingController<int, CartModel>? _pagingController;
  PagingController<int, CartModel> get pagingController {
    // Ensure the controller is always initialized
    _pagingController ??= PagingController(firstPageKey:0);
    return _pagingController!;
  }
  //int counterValue = 1;
  List<CartModel> cartProducts = [];

  @override
 void initState() {
    super.initState();
    couponController = TextEditingController();
    _initPagingController();

  }
  void init(PagingController<int, CartModel> pagingController) {
    _pagingController = pagingController;
    _pagingController!.addPageRequestListener((pageKey) {
      getCartList(pageKey);
    });
    loadCart();
  }
  void _initPagingController() {
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController!.addPageRequestListener((pageKey) {
      getCartList(pageKey);
    });
    getCartList(_pagingController!.firstPageKey);
  }


  Future<void> getCartList(int pageKey) async {
    if (loading) return; // Avoid duplicate calls
    loading = true;
    notifyListeners();

    final newItems = await CartDataHandler.listOfCartProducts(pageKey, pageSize);

    newItems.fold(
          (failure) {
        _pagingController!.error = failure;
      },
          (cartProducts) {
        final isLastPage = cartProducts.length < pageSize;
        if (isLastPage) {
          _pagingController!.appendLastPage(cartProducts);
        } else {
          final nextPageKey = pageKey + cartProducts.length;
          _pagingController!.appendPage(cartProducts, nextPageKey);
        }

        // Update the local cartProducts list
        this.cartProducts = _pagingController!.itemList ?? [];
        SharedPref.saveCart(this.cartProducts); // Save to SharedPreferences

        loading = false;
        notifyListeners();
      },
    );
  }
  Future<void> loadCart() async {
    cartProducts = await SharedPref.getCart();
    notifyListeners();
  }
  Future<void> clearCart() async {
    cartProducts.clear();
    await SharedPref.clearCart();
    notifyListeners();
  }
  // Future<void> getCartList(int pageKey) async {
  //   if (loading) return; // Avoid duplicate calls
  //   loading = true;
  //   notifyListeners();
  //   final newItems = await CartDataHandler.listOfCartProducts(
  //     pageKey,
  //     pageSize,
  //   );
  //   newItems.fold(
  //         (failure) {
  //       _pagingController!.error = failure;
  //     },
  //         (cartProducts) {
  //       print("Parsed Cart Products: ${cartProducts.length}");
  //       final isLastPage = cartProducts.length < pageSize;
  //       if (isLastPage) {
  //         _pagingController!.appendLastPage(cartProducts);
  //       } else {
  //         final nextPageKey = pageKey + cartProducts.length;
  //         _pagingController!.appendPage(cartProducts, nextPageKey);
  //       }
  //       // Update the cartProducts list
  //       this.cartProducts = _pagingController!.itemList ?? [];
  //       print("PagingController Item List: ${_pagingController!.itemList}");
  //       loading = false;
  //       notifyListeners();
  //     },
  //   );
  // }

  // double calculateSubtotal() {
  //   return cartProducts.fold(0, (sum, item) => sum + (item.price * item.quantity));
  // }
double calculateSubtotal(List<CartModel> cartProducts) {
    double subtotal = 0.0;

    for (var product in cartProducts) {
      subtotal += (product.price ?? 0) * (product.count ?? 1);
    }

    return subtotal;
  }

  Future deleteItemFromCart(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) =>
          AlertDeleteItemWidget(
            des: Strings.confirmDeleteItem.tr,
            mainText: Strings.deleteItem.tr,
            onButtonReject: currentContext_!.pop,
            onButtonAccept: currentContext_!.pop,
          ),
    );
  }
  void incrementCounter(CartModel product) {
    product.count = (product.count ?? 0) + 1;  // Ensure count is not null
    updateSubtotal();
    SharedPref.saveCart(cartProducts);
  }

  void decrementCounter(CartModel product) {
    if ((product.count ?? 1) > 1) {
      product.count = (product.count ?? 0) - 1;
      updateSubtotal();
      SharedPref.saveCart(cartProducts);
    }
  }

  void updateSubtotal() {
    notifyListeners();
  }


  onRemoveWarning(BuildContext ctx) {}


  @override
  void dispose() {
    couponController.dispose();
  // _pagingController?.dispose(); // Dispose the PagingController
    super.dispose();
  }
}