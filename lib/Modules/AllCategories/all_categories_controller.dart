import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../PopularProducts/Widgets/filter_bottom_sheet_widget.dart';


class AllCategoriesController extends ControllerMVC {
  // singleton
  factory AllCategoriesController() {
    _this ??= AllCategoriesController._();
    return _this!;
  }

  static AllCategoriesController? _this;
  bool loading = false;
  bool isSearch=false;
  bool autoValidate = false;
  late TextEditingController startController;
  late TextEditingController endController;
  TextEditingController searchText = TextEditingController();
  late TextEditingController searchController;
  AllCategoriesController._();

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
    getAllCategories();
  }
  Future filterBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder:(context)=>   FilterBottomSheetWidget(
          onButtonAccept:()=> context.pop(),
          onButtonReject:()=> context.pop(),
          autoValidate: autoValidate,
          startController: startController,
          endController: endController),
    );
  }
  Future getAllCategories() async {
    loading=true;

    setState(() {loading=false;});
  }
}