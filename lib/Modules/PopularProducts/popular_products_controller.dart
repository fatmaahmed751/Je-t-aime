import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Modules/PopularProducts/Widgets/filter_bottom_sheet_widget.dart";
import "package:je_t_aime/Modules/PopularProducts/popular_products_data_handler.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../Models/popular_products_model.dart";
import "../../Utilities/router_config.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/text_style_helper.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/custom_home_details_text_widget.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../Home/home_data_handler.dart";
import "../ProductDetails/Widgets/custom_check_box_widget.dart";

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
  List<PopularProductsModel> products = [];
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

  init() {
    getHomeDetails();
  }

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


  getHomeDetails() async {
    loading = true;
    setState(() {});
    final result = await HomeDataHandler.getHomeData();
    result.fold((l) {
      ToastHelper.showError(message: l.toString());
    }, (r) {
      // categories = List.from(((r["data"]["categories"] ?? []) as List)
      //     .map((e) => CategoryModel.fromJson(e)));
      // sliders = List.from(((r["data"]["sliders"] ?? []) as List)
      //     .map((e) => SliderModel.fromJson(e)));
      products = List.from(((r["data"]["popular_products"] ?? []) as List)
          .map((e) => PopularProductsModel.fromJson(e)));
    });
    print("succccccesssssssssss");
    setState(() {
      loading = false;
    });
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
