import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Models/cart_item_model.dart";
import "package:je_t_aime/Models/category_model.dart";
import "package:je_t_aime/Modules/Cart/cart_data_handler.dart";
import "package:je_t_aime/Modules/Home/Widgets/un_login_widget.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "package:provider/provider.dart";
import "../../Models/popular_products_model.dart";
import "../../Models/slider_model.dart";
import "../../Utilities/router_config.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/toast_helper.dart";
import "../../core/Language/app_languages.dart";
import "../../generated/assets.dart";
import "../PopularProducts/popular_products_data_handler.dart";
import "home_data_handler.dart";

class HomeController extends ControllerMVC {
  // singleton
  factory HomeController() {
    _this ??= HomeController._();
    return _this!;
  }

  static HomeController? _this;
  int selectedLanguage = 1;

  Future<void> loadCurrentLanguage(BuildContext ctx) async {
    await Provider.of<AppLanguage>(ctx, listen: false).fetchLocale(ctx);

    final currentLanguage =
        Provider
            .of<AppLanguage>(ctx, listen: false)
            .appLang;

    print("Current language: $currentLanguage");
    setState(() {
      selectedLanguage = currentLanguage == Languages.en ? 1 : 2;
    });
  }

  HomeController._();

  bool loading = false;
  int activeIndex = 0;
  bool isSearch = false;
  late TextEditingController searchController;

  int bottomNavCurrentIndex = 0;

  void changeBottomNav(int index) {
    bottomNavCurrentIndex = index;
    setState(() {});
  }

  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<PopularProductsModel> products = [];
  bool isLiked = false;
  int quyCount = 1;
  PopularProductsModel? productsModel;
  CartModel? cartModel;
  static const pageSize = 10;
  final bool _isDisposed = false;

  PagingController<int, PopularProductsModel> get pagingController =>
      _pagingController;

  final PagingController<int, PopularProductsModel> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    searchController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      getProducts(pageKey);
    });
    super.initState();
  }

  init() async {
    loadCurrentLanguage(currentContext_!);
    getHomeDetails();
    if (_pagingController.itemList == null ||
        _pagingController.itemList!.isEmpty) {
      getProducts(_pagingController.firstPageKey);
    }
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  onPageChange(int index) {
    setState(() {
      activeIndex = index;
    });
    activeIndex = index;
  }
  unLoginWidget(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) =>
          UnLoginWidgetBottomSheet(
            image: Assets.imagesNotRated,
            text: Strings.notRated.tr,
          ),
    );
  }
  addProductToCart({required BuildContext context, required PopularProductsModel product}) async {
    setState(() {
      loading = true;
    });
    print("Product ID: ${product.id}, Quantity: $quyCount");
    final result = await CartDataHandler.addToCart(
        productId: product.id ?? 0,
        quantity: quyCount);
    result.fold((l) {
      ToastHelper.showError(message: l.toString());
    }, (r) {
      ToastHelper.showSuccess(
        context: context,
        message: Strings.addToCartSuccess.tr,
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor:
        ThemeClass
            .of(context)
            .primaryColor,
      );
      print("addddddd");
    });
    setState(() {
      loading = false;
    });
  }

  addToFavorite({required PopularProductsModel product, required BuildContext context}) async {
    setState(() {
      loading = true;
    });

    final result = await PopularProductsDataHandler.addFavorite(
        productId: product.id ?? 0);
    result.fold((l) {
      ToastHelper.showError(message: l.errorModel.statusMessage);
    }, (r) {
      ToastHelper.showSuccess(
        context: context,
        message: Strings.addToFavoriteSuccess.tr,
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor:
        ThemeClass
            .of(context)
            .primaryColor,
      );
    });
    setState(() {
      loading = false;
    });
  }

  getHomeDetails() async {
    loading = true;
    setState(() {});
    final result = await HomeDataHandler.getHomeData();
    result.fold((l) {
      ToastHelper.showError(message: l.toString());
    }, (r) {
      categories = List.from(((r["data"]["categories"] ?? []) as List)
          .map((e) => CategoryModel.fromJson(e)));
      sliders = List.from(((r["data"]["sliders"] ?? []) as List)
          .map((e) => SliderModel.fromJson(e)));
      products = List.from(((r["data"]["popular_products"] ?? []) as List)
          .map((e) => PopularProductsModel.fromJson(e)));
    });
    print("succccccesssssssssss");
    setState(() {
      loading = false;
    });
  }

  Future<void> getProducts(int pageKey) async {
    try {
      final newItems = await PopularProductsDataHandler.getAllPopularProducts(
        pageKey,
        pageSize,
      );
      if (_isDisposed) return; // Cancel if disposed

      newItems.fold(
            (failure) {
          if (!_isDisposed) { // Check if disposed
            _pagingController.error = failure;
          }
        },
            (products) {
          if (!_isDisposed) { // Check if disposed
            final isLastPage = products.length < pageSize;
            if (isLastPage) {
              _pagingController.appendLastPage(products);
            } else {
              final nextPageKey = pageKey + products.length;
              _pagingController.appendPage(products, nextPageKey);
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

// Future<void> _handlePermissionPermanentlyDenied() async {
//   onPermanentDenied();
// }
// onPermanentDenied() async {
//   DialogHelper.custom(context: context).customDialog(
//       dialogWidget: AlertWarningWidget(
//         des: Strings.deniedPermission.tr,
//         onButtonAccept: () {
//           currentContext_!.pop();
//           openAppSettings();
//         },
//         onButtonReject: () {
//           currentContext_!.pop();
//         },
//         titleButtonAccept: Strings.settings.tr,
//         titleButtonReject: Strings.cancel.tr,
//       ),
//       dismiss: false);
// }
// Future<void> _handlePermissionDenied() async {
//   PermissionStatus newStatus = await Permission.notification.request();
//   switch (newStatus) {
//     case PermissionStatus.granted:
//       await handlePermissionGranted();
//       break;
//
//     case PermissionStatus.permanentlyDenied:
//       await _handlePermissionPermanentlyDenied();
//       break;
//
//     case PermissionStatus.denied:
//       onPermanentDenied();
//       break;
//     default:
//       ToastHelper.showError(message:Strings.unhandeledNotification.tr);
//   }
// }
// Future addDevice() async {
//   try{
//
//     PermissionStatus status = await Permission.notification.status;
//     switch (status) {
//       case PermissionStatus.granted:
//         await handlePermissionGranted();
//         break;
//
//       case PermissionStatus.denied:
//         await _handlePermissionDenied();
//         break;
//
//       case PermissionStatus.permanentlyDenied:
//         await _handlePermissionPermanentlyDenied();
//         break;
//
//       default:
//         ToastHelper.showError(message: "Unhandled notification permission status");
//     }
//
//   }catch(e){
//     ToastHelper.showError(message: e.toString());
//   }
//
// }
// Future<void> handlePermissionGranted() async {
//   final result = await HomeDataHandler.addDevice();
//   result.fold(
//           (l){
//
//             ToastHelper.showError(message: l.toString());},
//           (r) {
//         //ToastHelper.showSuccess(message: "doneee");
//       }
//   );
// }


}
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
