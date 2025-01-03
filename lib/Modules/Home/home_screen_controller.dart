import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:je_t_aime/Models/category_model.dart';
import 'package:je_t_aime/Widgets/custom_product_container_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Models/packages_model.dart';
import '../../Utilities/strings.dart';

class HomeController extends ControllerMVC {
  // singleton
  factory HomeController() {
    _this ??= HomeController._();
    return _this!;
  }

  static HomeController? _this;

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
  imageName:"https://s3-alpha-sig.figma.com/img/00fa/97ec/01ce87e19b91f93352006ed31975a494?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=m2rUDkqU0~nrN-5VaDKYDFY5kdA-TXxnnNV-L6jnt9tjbL0cDr~UcsSx38dE4K8mrBnFuJqiKFMOA2Ey-2gJO2pacpy7g6cXgu7HDDpaYgzLBxPBy6WFzcHbuIA7jMMYZpNPmxkfB04nD-pNXJ~HpxuqJn4VbKBQr1frCyP0wsZkvbxWiftSRZkQH9pMeirkiIEetm0rdhfaCrggxi9Un9c6n89FjBKhayS3DSvK8--oQ~g7h~FRPW65XuF4n-GttMOJWntLycrxci9Xcct-OkHj-sdNeb5C1vdGoC0Q6pgeHA4VKrPC44JfRt2oSWnY1U61MlIJAQ0M5AVmChjTXg__"),
  PackagesModel(
  imageName:"https://s3-alpha-sig.figma.com/img/5568/cd9b/88e28790561337fbf7d739185f736f2b?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mHBprdsEPFDJTDym~H13uz6h98JqATqXmZmM~4rk1M3~W25vsbAncMCuvDPP6V3LIu7ttYUoH2bG4tXiwFp8wAbMZgr0cjW85smN6vQjo~SdM7dqnOXDHnLCuZUT51Lz3LPEEzKZ6VZdFrmQy0ao6nGfGFeBm-3DqgxTT3w6pqhWNN87tbZW1jgJONgYY9F5abqurBTPhqskxHT5pC1q1ZmlpqOv3LfAvqqqg~y3QSdct9C4R4EUvTVaxqkSFCuTiQPESgNnyDhBd0iTpHFzwzawTaqmkGiAcbHv6GrBK7~CmmZzQ2Jdz6MfVilz8ceVa3JzFrDYeQPl0fETgtHEDQ__"),
    PackagesModel(
        imageName:"https://s3-alpha-sig.figma.com/img/00fa/97ec/01ce87e19b91f93352006ed31975a494?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=m2rUDkqU0~nrN-5VaDKYDFY5kdA-TXxnnNV-L6jnt9tjbL0cDr~UcsSx38dE4K8mrBnFuJqiKFMOA2Ey-2gJO2pacpy7g6cXgu7HDDpaYgzLBxPBy6WFzcHbuIA7jMMYZpNPmxkfB04nD-pNXJ~HpxuqJn4VbKBQr1frCyP0wsZkvbxWiftSRZkQH9pMeirkiIEetm0rdhfaCrggxi9Un9c6n89FjBKhayS3DSvK8--oQ~g7h~FRPW65XuF4n-GttMOJWntLycrxci9Xcct-OkHj-sdNeb5C1vdGoC0Q6pgeHA4VKrPC44JfRt2oSWnY1U61MlIJAQ0M5AVmChjTXg__"),
    PackagesModel(
        imageName:"https://s3-alpha-sig.figma.com/img/5568/cd9b/88e28790561337fbf7d739185f736f2b?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mHBprdsEPFDJTDym~H13uz6h98JqATqXmZmM~4rk1M3~W25vsbAncMCuvDPP6V3LIu7ttYUoH2bG4tXiwFp8wAbMZgr0cjW85smN6vQjo~SdM7dqnOXDHnLCuZUT51Lz3LPEEzKZ6VZdFrmQy0ao6nGfGFeBm-3DqgxTT3w6pqhWNN87tbZW1jgJONgYY9F5abqurBTPhqskxHT5pC1q1ZmlpqOv3LfAvqqqg~y3QSdct9C4R4EUvTVaxqkSFCuTiQPESgNnyDhBd0iTpHFzwzawTaqmkGiAcbHv6GrBK7~CmmZzQ2Jdz6MfVilz8ceVa3JzFrDYeQPl0fETgtHEDQ__"),
  ];
  List<CustomProductContainerWidget> products=[
    const CustomProductContainerWidget(),
    const CustomProductContainerWidget(),
  ];
  List<CategoryModel> categoryModel = [
    CategoryModel(
      imageName:
          "https://s3-alpha-sig.figma.com/img/d3a6/c1b1/e0bc0c5cc245b28432588e0de183ed49?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mT7voEctd6CpKiPSHWC-QRC5YE7AQ6z~hAGZovIMQ8mcjKS8~YyTtg7pBgSRH~gZXgvFxwIRmWghAsTnefbueycoJkVFxHr2dRogX78wvtWXQo1jsw6FF7paqOa2DoSP0d45z4njD1rZ08F5b4z2zExexUMNatSTYwXh3TMaINuH3RJnUXDKRbqwG-1mLDvkp-cHqo-SEVXYalyANHMEjnH22~FW22gPOkS1hCJi852i~Vi-ugIiM-Sy5sbcBb8LVCYcQ555l8OPfSUAfInRq4-C-keZ~tiaQoSlAjCnwHMd-L9PHt8MnNaC7NrfwCEyWi4Bp04k73nwB~AfRWrUHw__",
      mainText: Strings.faceCare.tr,
    ),
    CategoryModel(
      imageName:
          "https://s3-alpha-sig.figma.com/img/301c/ce15/6a7a56d86823e093a9d5b4bde2d360d7?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=p2yudF7nY4l~yx5U5pCZJamUrcT5e~Ylahk2npC9DbOOagsZlKHOBC9dtEFsSY-QdAbYCURAOksPLX7WrbXjvBTKOOvRfu4iI2uYMovt31NzAmvHehkQK3ZnZhWBgL7nJfqzNTUJlfgLl0VpcCVRwgwI9j5lAhkjPLIJooCtI8Ar2EcHplrC3RyUJxkhhtneMYGzFxVZjeNKoofy9T3vhndWE1qMaZ4D0zic8HP5Q51VlzsqfnubYgL6lujNasNggloN6HQh0grbNkvRdPVfa8vpgRiOXzKALUT3HX1UnKZRsmx6AnqFoNeS-LFIhXlSlD1Y4GAN8CmPruJcBacLBA__",
      mainText: Strings.bodyCare.tr,
    ),
    CategoryModel(
      imageName:
          "https://s3-alpha-sig.figma.com/img/cc6d/6eb2/78f794ca3c533274d4c1ed7c190803ce?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oa7Eh2KlIzXhUh3zjnezr2qxqgWLtY2BSBpEd5zdejlS19IanoLx1bxNC7D14D5Y0eiPAQi2lfW7MnehedQxADE8Ex7Sk2WWqGPNqA-E3P~P3SenyjzlHPJfJlsMrR4isy~PoL3Am6gdbmnh5tMKR2pT-q8lDibos0bNq~-8fLIP-HdKc2bTMjiuBdWRV3ne6oehGsI28E8BiyJyESSwu1ueWNg1~QXL~JwTPasyFa1af3k4dbWqBUh6Yw1fg5JRV9CIPR6s7jElwjKC-fGhC2CCILc2W-2waRSzWv5GQCxR4Hm1vbDTFSi56wDBYLvXw3BKRidEOh7KM5AsnFKuyg__",
      mainText: Strings.hairCare.tr,
    ),
    CategoryModel(
      imageName:
          "https://s3-alpha-sig.figma.com/img/acac/7430/d783b531835eeea6d1040a1047cca690?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=B~TJH06KK~2-nKTbHUgS-5QWzs3PohCbBOv~O7f-n5TAq2yEYvBxPj5Q5FKxEcCmW1-KvTE5ynDCp~Ig6H2XSjAVTnHcuuBPZCVR51SauF3fLF8~fd3LcqY~MxHEYkVctmXpjWWVYRmqqJgn8jjKIYLiZHwIBLn3wwnXaFJxlxkzO6S~AcN5waLElnezjLtGk6gkdJjlSZwqssPQBqNHGjIJAMqJcEyCvCMxvu5aZ0MswbDzUT9eWEXAW~jd7iozuVwny67GPigYItISDdZ~LLcm9QXQnYDY2ARMXp2vpADNu7Kt5vNod0nNvJ5MRzDxt1Q1MHc-Q~ZOIXhuJj0Vtw__",
      mainText: Strings.nailCare.tr,
    ),
  ];
  bool isLiked = false;


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
}
