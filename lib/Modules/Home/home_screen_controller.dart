import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:je_t_aime/Models/category_model.dart';
import 'package:je_t_aime/Widgets/custom_product_container_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import '../../Models/packages_model.dart';
import '../../Utilities/router_config.dart';
import '../../Utilities/strings.dart';
import '../../core/Language/app_languages.dart';
import '../../generated/assets.dart';

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

    final currentLanguage = Provider.of<AppLanguage>(ctx, listen: false).appLang;

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
  List imageUrl = [
    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDKErC39UCJ75tiSVi9KyKLpF921rkFpP1Zg&s",
    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDKErC39UCJ75tiSVi9KyKLpF921rkFpP1Zg&s",
    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDKErC39UCJ75tiSVi9KyKLpF921rkFpP1Zg&s",
  ];
  int bottomNavCurrentIndex = 0;
  void changeBottomNav(int index) {
    bottomNavCurrentIndex = index;
    setState((){});
  }
  List<PackagesModel> packagesModel = [
  PackagesModel(
    imageName:Assets.imagesPackagesOne,),
  PackagesModel(
      imageName:Assets.imagesPackagesTwo,),
   PackagesModel(imageName:Assets.imagesPackagesOne,),
    PackagesModel( imageName:Assets.imagesPackagesTwo,),
  ];
  List<CustomProductContainerWidget> products=[
    const CustomProductContainerWidget(),
    const CustomProductContainerWidget(),
  ];
 late List<CategoryModel> categoryModel;

  // late List<BottomNavBarItemModel> items;
  // void updateBottomNav() {
  //   setState(() {
  //     items = [
  //       BottomNavBarItemModel(
  //         iconPath: Assets.imagesHome,
  //         selectedIconPath: Assets.imagesHome,
  //         title: Strings.home,
  //         routeName: HomeScreen.routeName,
  //         type: SelectedBottomNavBar.home,
  //       ),
  //       BottomNavBarItemModel(
  //         iconPath: Assets.imagesFavNav,
  //         selectedIconPath: Assets.imagesFavNav,
  //         title: Strings.favorite,
  //         routeName: FavoriteScreen.routeName,
  //         type: SelectedBottomNavBar.favorite,
  //       ),
  //       BottomNavBarItemModel(
  //         iconPath: Assets.imagesNotNav,
  //         selectedIconPath: Assets.imagesNotNav,
  //         title: Strings.notification,
  //         routeName: NotificationsScreen.routeName,
  //         type: SelectedBottomNavBar.notification,
  //       ),
  //     BottomNavBarItemModel(
  //   iconPath: Assets.imagesProfileNav,
  //   selectedIconPath: Assets.imagesProfileNav,
  //   title: Strings.profile,
  //   routeName: UserProfileScreen.routeName,
  //   type: SelectedBottomNavBar.account,
  // )
  //
  //     ];
  //   });
  // }

 void update() {
   setState(() {
     categoryModel = [
       CategoryModel(
         imageName: Assets.imagesFace,
         mainText: Strings.faceCare.tr,
       ),
       CategoryModel(

         imageName: Assets.imagesBody,
         mainText: Strings.bodyCare.tr,
       ),
       CategoryModel(
         imageName: Assets.imagesHair,
         mainText: Strings.hairCare.tr,
       ),
       CategoryModel(
         imageName: Assets.imagesNail,
         mainText: Strings.nailCare.tr,
       ),

     ];
   });
 }
   bool isLiked = false;
init()async{
  loadCurrentLanguage(currentContext_!);
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
  // Future getHomeData() async {
  //   loading=true;
  //   setState(() { });
  //   final result = await HomeDataHandler.getHomeData();
  //   result.fold((l) {
  //     ToastHelper.showError(message: l.toString());},(r) {
  //
  //     categories=List.from(((r["data"]["categories"]??[]) as List).map((e) => CategoryElementModel.fromJson(e)));
  //     //banners=List.from(((r["data"]["banners"]??[]) as List).map((e) => BannerModel.fromJson(e)));
  //     products=List.from(((r["data"]["products"]??[]) as List).map((e) => BannerModel.fromJson(e)));
  //     // if(sliders!=null){
  //     //   sliders=List.from(((r["data"]["sliders"]??[]) as List).map((e)=>BannerModel.fromJson(e)));
  //     // }
  //   });
  //   setState(() {loading=false;});
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

