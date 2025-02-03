import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/PopularProducts/Widgets/filter_bottom_sheet_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/bottom_sheet_helper.dart';
import '../../Utilities/shared_preferences.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/custom_home_details_text_widget.dart';
import '../../Widgets/toast_helper.dart';
import '../ProductDetails/Widgets/custom_check_box_widget.dart';

class PopularProductController extends ControllerMVC {
  // singleton
  factory PopularProductController() {
    _this ??= PopularProductController._();
    return _this!;
  }

  static PopularProductController? _this;
  bool isSearch = false;
  bool isLiked = false;
  bool loading = false;
  bool autoValidate = false;
  TextEditingController searchText = TextEditingController();
  PopularProductController._();
  late TextEditingController searchController;
  late TextEditingController startController;
  late TextEditingController endController;
  @override
  void initState() {
    searchController = TextEditingController();
    startController = TextEditingController();
    endController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  init() {}

  Future onSearchReq({String? search}) async {
    loading = true;

    setState(() {
      loading = false;
    });
  }

  Future onSearchReqInCategory(
      {String? search, required int categoryId}) async {
    loading = true;

    setState(() {
      loading = false;
    });
  }

  onSearch({
    String? search,
  }) async {
    if (search == null || search.isEmpty) return;
  }

  Future getProducts({bool refresh = false}) async {
    setState(() {
      loading = false;
    });
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
    loading = true;

    setState(() {
      loading = false;
    });
  }

  Future deleteFavorite({required int productId}) async {
    setState(() {
      loading = false;
    });
  }

  Future getAllCategories() async {
    setState(() {
      loading = false;
    });
  }

  Future filterBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) => FilterBottomSheetWidget(
          onButtonAccept: () => context.pop(),
          onButtonReject: () => context.pop(),
          checkBoxWidget: const CustomCheckBoxWidget(),
          sideTextWidget: CustomHomeDetailsTextWidget(
            text: Strings.categories.tr,
            style: TextStyleHelper.of(context).b_20.copyWith(
                color: ThemeClass.of(context).mainBlack,
                fontWeight: FontWeight.w500),
          ),
          autoValidate: autoValidate,
          startController: startController,
          endController: endController),
    );
  }

  Future filter(
      {required int start,
      required int end,
      required List categoryIds,
      required List rateIds}) async {
    loading = true;
    setState(() {});
    setState(() {
      loading = false;
    });
  }
}
