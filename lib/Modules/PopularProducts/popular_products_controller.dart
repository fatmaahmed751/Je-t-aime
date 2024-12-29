import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/bottom_sheet_helper.dart';
import '../../Utilities/shared_preferences.dart';
import '../../Widgets/toast_helper.dart';
import 'Widgets/filter_widget.dart';

class PopularProductController extends ControllerMVC {
  // singleton
  factory PopularProductController() {
    _this ??= PopularProductController._();
    return _this!;
  }

  static PopularProductController? _this;
  bool isSearch=false;
  bool isLiked=false;
  bool loading = false;
  bool autoValidate = false;
  TextEditingController searchText = TextEditingController();
  PopularProductController._();
  late TextEditingController searchController;
  late TextEditingController startController;
  late TextEditingController endController;
  @override
  void initState() {
    searchController=TextEditingController();
    startController=TextEditingController();
    endController=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    startController.dispose();
    endController.dispose();
    super.dispose();

  }
  init(){


  }

  Future onSearchReq({String? search}) async {
    loading=true;

    setState(() {loading=false;});
  }
  Future onSearchReqInCategory({String? search,required int categoryId}) async {
    loading=true;

    setState(() {loading=false;});
  }
  onSearch({String? search,}) async {
    if (search == null || search.isEmpty) return;

  }

  Future getProducts({bool refresh=false}) async {
    setState(() {loading=false;});
  }
  Future addFavorite({required int productId}) async {
    setState(() {
      loading = true;
    });

   //   ToastHelper.showSuccess(message: ,icon: '');


    setState(() {
      loading = false;
    });
  }
  Future getCategoryProducts({required int categoryId}) async {
    loading=true;

    setState(() {loading=false;});
  }
  Future deleteFavorite({required int productId}) async {

    setState(() {
      loading = false;
    });
  }
  Future getAllCategories() async {

    setState(() {loading=false;});
  }
  onFilter(BuildContext ctx) {
    BottomSheetHelper.bottomSheet(
        context: ctx,
        widget: ProductFilter(
          onApply: (start,end,categoryIds,rateIds) {

            // filterDateId=dateId;
               ctx.pop();
              filter(start: start??0, end: end??0, categoryIds:categoryIds, rateIds:rateIds);
          },
          startController:startController,
          endController:endController, autoValidate:autoValidate , onAutoValidate: () {
            setState((){
              autoValidate=true;
            });
        },
        ));
  }
  Future filter({required int start,required int end,required List categoryIds,required List rateIds }) async {
    loading=true;
    setState(() { });
    setState(() {loading=false;});
  }
}