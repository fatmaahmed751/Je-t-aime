import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:je_t_aime/Models/cart_item_model.dart";
import "package:je_t_aime/Models/category_model.dart";
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
        Provider.of<AppLanguage>(ctx, listen: false).appLang;

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
  int quyCount =1;
  PopularProductsModel? productsModel;
 CartModel? cartModel;
  init() async {
    loadCurrentLanguage(currentContext_!);
    getHomeDetails();
  }

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
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
addProductToCart()async{
  loading = true;
  setState(() {});
  print("Product ID: ${productsModel?.id}, Quantity: $quyCount");
  final result = await HomeDataHandler.addToCart(
      productId: productsModel?.id??0,
      quantity: quyCount);
  result.fold((l) {
    ToastHelper.showError(message: l.toString());
  }, (r) {
    ToastHelper.showSuccess(
      context: currentContext_!,
      message: Strings.addToCartSuccess.tr,
      icon: SvgPicture.asset(
        Assets.imagesSubmit,
        width: 60.w,
        height: 50.h,
        fit: BoxFit.cover,
      ),
      backgroundColor:
      ThemeClass.of(currentContext_!).primaryColor,
    );
    print("addddddd");
});
  setState(() {
    loading = false;
  });
}
  addToFavorite({required int productId}) async {
    setState(() {
      loading = true;
    });

    final result = await PopularProductsDataHandler.addFavorite(
        productId:productId);
    result.fold((l) {
      ToastHelper.showError(message: l.errorModel.statusMessage);
    }, (r) {
      ToastHelper.showSuccess(
        context: currentContext_!,
        message: Strings.addToFavoriteSuccess.tr,
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor:
        ThemeClass.of(currentContext_!).primaryColor,
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
}
// Future<void> _handlePermissionPermanentlyDenied() async {
//   onPermanentDenied();
// }
// onPermanentDenied() async {
//   DialogHelper.custom(context: currentContext_!).customDialog(
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

// Future getBanners() async {
//   loading=true;
//   setState(() { });
//   final result = await HomeDataHandler.getBanners();
//   result.fold((l) {
//
//     ToastHelper.showError(message: l.toString());},(r) {
//     banners=r;
//   });
//   setState(() {loading=false;});
// }
//
// Future getOffers({bool refresh=false}) async {
//   if(refresh)offersPagination = GenericPaginationModel<BannerModel>();
//   if(offersPagination.data.isEmpty){
//     loading=true;
//     setState(() { });
//   }
//   final result = await PopularProductsDataHandler.getProducts(oldPagination:offersPagination);
//   result.fold((l) => null, (r) {
//     final oldItems = offersPagination.data;
//     offersPagination = r;
//     print("pagination${offersPagination.data.length}");
//     print("real pagination${r.data.length}");
//     if(!refresh)offersPagination.data.insertAll(0, oldItems);
//   });
//   if (!offersPagination.hasNextPge) {
//     offersRefreshController.loadNoData();
//   } else {
//     offersRefreshController.loadComplete();
//   }
//   if(refresh)offersRefreshController.refreshCompleted();
//   setState(() {loading=false;});
// }

// Future getOffers() async {
//   loading=true;
//   setState(() { });
//   final result = await HomeDataHandler.getOffers();
//   result.fold((l){
//     print('heyyy${l.errorModel.statusMessage}');
//     },(r) {
//     offers=r;
//   });
//   setState(() {loading=false;});
// }

// Future addFavorite({required int productId}) async {
//   setState(() {
//     loading = true;
//   });
//   final result = await PopularProductsDataHandler.addFavorite(
//       productId:productId);
//   result.fold((l) {
//
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
