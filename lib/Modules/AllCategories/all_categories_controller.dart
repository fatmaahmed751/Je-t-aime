// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
// import 'package:mvc_pattern/mvc_pattern.dart';
// import "package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart";
//
// import "../../Models/category_model.dart";
// import "../../Models/generic_pagination_model.dart";
// import "../../Models/categories_product_model.dart";
// import "../../Widgets/toast_helper.dart";
// import '../PopularProducts/Widgets/filter_bottom_sheet_widget.dart';
// import "all_categories_data_handler.dart";
//
// class AllCategoriesController extends ControllerMVC {
//   // singleton
//   factory AllCategoriesController() {
//     _this ??= AllCategoriesController._();
//     return _this!;
//   }
//
//   static AllCategoriesController? _this;
//   bool loading = false;
//   bool isSearch = false;
//   bool autoValidate = false;
//   late TextEditingController startController;
//   late TextEditingController endController;
//  late TextEditingController searchText;
//   late TextEditingController searchController;
//   List<CategoryProductModel>categories = [];
//   CategoryModel? categoryProductModel;
//   AllCategoriesController._();
//   static const pageSize = 10;
//   PagingController<int, CategoryProductModel> get pagingController => _pagingController;
//
//   final PagingController<int, CategoryProductModel> _pagingController =
//   PagingController(firstPageKey: 0);
//
//   @override
//   void initState() {
//     searchController = TextEditingController();
//     startController = TextEditingController();
//     endController = TextEditingController();
//     _pagingController.addPageRequestListener((pageKey) {
//       getCategories(pageKey,categoryProductModel?.id??0);
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     startController.dispose();
//     endController.dispose();
//     _pagingController.dispose();
//     super.dispose();
//   }
//
//   init({required int categoryIdd}) {
//     debugPrint("Category ID: $categoryIdd");
//     getCategories(_pagingController.firstPageKey,categoryIdd);
//   }
//   Future<void> getCategories(int pageKey,int categoryProductId) async {
//     debugPrint("Fetching products for category IDbbbbbbbbbbb: $categoryProductId");
//     try {
//       final newItems = await AllCategoriesDataHandler.getAllCategories(
//           pageKey,
//           pageSize,
//           categoryProductId
//       );
//       newItems.fold(
//             (failure) {
//           _pagingController.error = failure;
//         },
//             (categories) {
//           final isLastPage = categories.length < pageSize;
//           if (isLastPage) {
//             _pagingController.appendLastPage(categories);
//           } else {
//             final nextPageKey = pageKey + categories.length;
//             _pagingController.appendPage(categories, nextPageKey);
//           }
//         },
//       );
//     } catch (error) {
//       _pagingController.error = error;
//     }
//   }
//
//   Future filterBottomSheet(BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       // isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
//       ),
//       builder: (context) =>
//           FilterBottomSheetWidget(
//               onButtonAccept: () => context.pop(),
//               onButtonReject: () => context.pop(),
//               autoValidate: autoValidate,
//               startController: startController,
//               endController: endController),
//     );
//   }
//
//   // listOfCategoryProduct() async {
//   //   loading = true;
//   //   final result = await AllCategoriesDataHandler.getAllCategories(
//   //   );
//   //   result.fold((l) => null, (r) {
//   //     categories = r;
//   //   });
//   //   setState(() {
//   //     loading = false;
//   //   });
//   // }
// }
import "package:flutter/material.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:mvc_pattern/mvc_pattern.dart";

import "../../Models/categories_product_model.dart";
import "../../Models/category_model.dart";
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
   int? categoryId; // Add this field
  bool _isDisposed = false; // Custom flag to track disposal
  AllCategoriesController._(); // Update constructor
  static const pageSize = 10;
  PagingController<int, CategoryProductModel> get pagingController => _pagingController;

  final PagingController<int, CategoryProductModel> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    searchController = TextEditingController();
    startController = TextEditingController();
    endController = TextEditingController();
    searchText= TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      getCategories(pageKey, categoryProductModel?.id??0); // Use the categoryId from the controller
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

  Future<void> getCategories(int pageKey, int categoryProductId) async {
    try {
      final newItems = await AllCategoriesDataHandler.getAllCategories(
        pageKey,
        pageSize,
        categoryProductId,
      );
      if (_isDisposed) return; // Cancel if disposed

      newItems.fold(
            (failure) {
          if (!_isDisposed) { // Check if disposed
            _pagingController.error = failure;
          }
        },
            (categories) {
          if (!_isDisposed) { // Check if disposed
            final isLastPage = categories.length < pageSize;
            if (isLastPage) {
              _pagingController.appendLastPage(categories);
            } else {
              final nextPageKey = pageKey + categories.length;
              _pagingController.appendPage(categories, nextPageKey);
            }
          }
        },
      );
    } catch (error) {
      if (!_isDisposed) { // Check if disposed
        _pagingController.error = error;
      }
    }
  }
}