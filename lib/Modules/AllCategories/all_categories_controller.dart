import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";

import "../../Models/cart_item_model.dart";
import "../../Models/categories_product_model.dart";
import "../../Models/category_model.dart";
import "../../Models/popular_products_model.dart";
import "../../Utilities/shared_preferences.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/text_style_helper.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/custom_home_details_text_widget.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../Cart/cart_data_handler.dart";
import "../Home/Widgets/un_login_widget.dart";
import "../PopularProducts/Widgets/filter_bottom_sheet_widget.dart";
import "../PopularProducts/popular_products_data_handler.dart";
import "../ProductDetails/Widgets/add_to_cart_bottom_sheet.dart";
import "../ProductDetails/Widgets/custom_check_box_widget.dart";
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
  late TextEditingController searchText;
  late TextEditingController searchController;
  List<CategoryProductModel> categories = [];
  CategoryModel? categoryProductModel;
  List<CartModel> cartProducts=[];
  CategoryProductModel?category;
  int quyCount = 1;

  int? categoryId; // Add this field
// Custom flag to track disposal
  AllCategoriesController._(); // Update constructor
  static const pageSize = 10;
  PagingController<int, CategoryProductModel> get pagingController =>
      _pagingController;

  final PagingController<int, CategoryProductModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    searchController = TextEditingController();
    startController = TextEditingController();
    endController = TextEditingController();
    searchText = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      getCategories(
          pageKey,
          categoryProductModel?.id ?? 1); // Use the categoryId from the controller
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  void init({required int categoryIdd}) {
    if (_pagingController.itemList == null ||
        _pagingController.itemList!.isEmpty) {
      getCategories(_pagingController.firstPageKey, categoryIdd);
    }
  }
  Future<bool> isProductInCart(int productId) async {
    final cartProducts = await SharedPref.getCart();
    return cartProducts.any((cartProduct) => cartProduct.id == productId);
  }
  addProductToCart({
    required BuildContext context, required CategoryProductModel category})
  async {
    setState(() {
      loading = true;
    });
    print("Product ID: ${category.id}, Quantity: $quyCount");
    final result = await CartDataHandler.addToCart(
        productId: category.id ?? 0,
        quantity: quyCount);
    result.fold((l) {
      ToastHelper.showError(message: l.toString());
    }, (r)async {
      print("adddddddddddd");
      ToastHelper.showSuccess(
        context: context,
        message: Strings.addToCartSuccess.tr,
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor: ThemeClass.of(context).primaryColor,
      );
      setState(() {
        loading = false;
      });
    });

  }

  // Future addToCartSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     // isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
  //     ),
  //     builder: (context) =>  AddToCartBottomSheetWidget(
  //       products: [],
  //       addThisToCart:() => addProductToCart(
  //           category:category??CategoryProductModel(),
  //           context: context),
  //     ),
  //   );
  // }


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

  Future<void> getCategories(int pageKey, int categoryProductId) async {
    if (loading) return; // Avoid duplicate calls
    loading = true;
    notifyListeners();
    final newItems = await AllCategoriesDataHandler.getAllCategories(
      pageKey,
      pageSize,
      categoryProductId,
    );
    newItems.fold(
      (failure) {
        _pagingController.error = failure;
      },
      (categories) {
        final isLastPage = categories.length < pageSize;
        print("Categobbbbbbriesvvvvvvvv Length: ${categories.length}");
        print("Fetching categorys for category ID: $categoryProductId");

        if (isLastPage) {
          _pagingController.appendLastPage(categories);
        } else {
          final nextPageKey = pageKey + categories.length;
          _pagingController.appendPage(categories, nextPageKey);
        }
        loading = false;
        notifyListeners();
      },
    );
  }

  addToFavorite(
      {required CategoryProductModel product,
      required BuildContext context}) async {
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
        backgroundColor: ThemeClass.of(context).primaryColor,
      );
    });
    setState(() {
      loading = false;
    });
  }

  unLoginWidget(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) => UnLoginWidgetBottomSheet(
        image: Assets.imagesNotRated,
        text: Strings.notRated.tr,
      ),
    );
  }

  // Future<void> getCategories(int pageKey, int categoryProductId) async {
  //   try {
  //     final newItems = await AllCategoriesDataHandler.getAllCategories(
  //       pageKey,
  //       pageSize,
  //       categoryProductId,
  //     );
  //     if (_isDisposed) return; // Cancel if disposed
  //
  //     newItems.fold(
  //           (failure) {
  //         if (!_isDisposed) { // Check if disposed
  //           _pagingController.error = failure;
  //         }
  //       },
  //           (categories) {
  //         if (!_isDisposed) { // Check if disposed
  //           final isLastPage = categories.length < pageSize;
  //           if (isLastPage) {
  //             _pagingController.appendLastPage(categories);
  //           } else {
  //             final nextPageKey = pageKey + categories.length;
  //             _pagingController.appendPage(categories, nextPageKey);
  //           }
  //         }
  //       },
  //     );
  //   } catch (error) {
  //     if (!_isDisposed) { // Check if disposed
  //       _pagingController.error = error;
  //     }
  //   }
  // }
}
