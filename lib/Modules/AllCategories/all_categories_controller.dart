import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import "package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart";

import "../../Models/category_model.dart";
import "../../Models/generic_pagination_model.dart";
import "../../Models/categories_product_model.dart";
import "../../Widgets/toast_helper.dart";
import '../PopularProducts/Widgets/filter_bottom_sheet_widget.dart';
import "all_categories_data_handler.dart";

class AllCategoriesController extends ControllerMVC {
  // singleton
  factory AllCategoriesController() {
    _this ??= AllCategoriesController._();
    return _this!;
  }

  static AllCategoriesController? _this;
  bool loading = false;
  bool isSearch = false;
  bool autoValidate = false;
  late TextEditingController startController;
  late TextEditingController endController;
  TextEditingController searchText = TextEditingController();
  late TextEditingController searchController;
  List<CategoryModel>categories = [];
  RefreshController productsRefreshController = RefreshController(
      initialRefresh: false);
  GenericPaginationModel<
      CategoryProductModel> categoryProducts = GenericPaginationModel<
      CategoryProductModel>();

  AllCategoriesController._();

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

  init({required CategoryModel categoryModel}) {
    categoryProducts = GenericPaginationModel<CategoryProductModel>();
    productsRefreshController = RefreshController(initialRefresh: false);
    listOfCategoryProduct(id: categoryModel.id ?? 0);
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
      builder: (context) =>
          FilterBottomSheetWidget(
              onButtonAccept: () => context.pop(),
              onButtonReject: () => context.pop(),
              autoValidate: autoValidate,
              startController: startController,
              endController: endController),
    );
  }

  getAllCategories() async {
    loading = true;
    final result = await AllCategoriesDataHandler.getAllCategories();
    result.fold((l) {
      ToastHelper.showError(message: l.toString());
    }, (r) {
      categories = r;
    });
    setState(() {
      loading = false;
    });
  }

  listOfCategoryProduct({bool refresh = false, int? id}) async {
    if (refresh) {
      categoryProducts = GenericPaginationModel<CategoryProductModel>();
    }
    if (categoryProducts.data.isEmpty) {
      loading = true;
      setState(() {});
    }
    loading = true;
    final result = await AllCategoriesDataHandler.getAllCategoriesProduct(
        oldPagination: categoryProducts, id: id ?? 0);
    result.fold((l) => null, (r) {
      final oldItems = categoryProducts.data;
      categoryProducts = r;
      print("pagination${categoryProducts.data.length}");
      print("real pagination${r.data.length}");
      if (!refresh) categoryProducts.data.insertAll(0, oldItems);
    });
    if (!categoryProducts.hasNextPge) {
      productsRefreshController.loadNoData();
    } else {
      productsRefreshController.loadComplete();
    }
    if (refresh) productsRefreshController.refreshCompleted();
    setState(() {
      loading = false;
    });
  }
}
