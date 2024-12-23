import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
class NotLoginRewardsRowController extends ControllerMVC {
  // singleton
  factory NotLoginRewardsRowController() {
    _this ??= NotLoginRewardsRowController._();
    return _this!;
  }
  static NotLoginRewardsRowController? _this;
  NotLoginRewardsRowController._();
  bool loading=false,autoValidate = false;
  bool isClick = false;
  bool isSearch= false;
  late TextEditingController searchController;
  // List<BannerModel> products=[];
  // GenericPaginationModel<BannerModel> productsPagination = GenericPaginationModel<BannerModel>();
  // RefreshController productsRefreshController= RefreshController(initialRefresh: false);
  @override
  void initState() {
    searchController=TextEditingController();
   // getProducts();
    super.initState();
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  init(){
    // productsPagination = GenericPaginationModel<BannerModel>();
    // productsRefreshController= RefreshController(initialRefresh: false);
    // getProducts();
  }
  // Future getProducts() async {
  //   loading=true;
  //   setState(() { });
  //   final result = await PopularProductsDataHandler.getProducts();
  //   result.fold((l) =>ToastHelper.showError(message: l.toString()),(r) {
  //     products=r;
  //   });
  //   setState(() {loading=false;});
  // }
  // Future getProducts({bool refresh=false}) async {
  //   if(refresh)productsPagination = GenericPaginationModel<BannerModel>();
  //   if(productsPagination.data.isEmpty){
  //     loading=true;
  //     setState(() { });
  //   }
  //   final result = await PopularProductsDataHandler.getProducts(oldPagination:productsPagination);
  //   result.fold((l) => null, (r) {
  //     final oldItems = productsPagination.data;
  //     productsPagination = r;
  //     if(!refresh)productsPagination.data.insertAll(0, oldItems);
  //   });
  //   if (!productsPagination.hasNextPge) {
  //     productsRefreshController.loadNoData();
  //   } else {
  //     productsRefreshController.loadComplete();
  //   }
  //   if(refresh)productsRefreshController.refreshCompleted();
  //   setState(() {loading=false;});
  // }
}
