import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Modules/AllCategories/widget/category_product_widget.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";

import "../../Models/categories_product_model.dart";
import "../../Models/category_model.dart";
import "../../Utilities/shared_preferences.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/custom_app_bar_widget.dart";
import "../../Widgets/loading_screen.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../Home/Widgets/search_widget.dart";
import "all_categories_controller.dart";

class AllCategoriesScreen extends StatefulWidget {
  static const routeName = "AllCategoriesScreen";
  final CategoryModel? model;
  final CategoryProductModel categoryProductModel;
  const AllCategoriesScreen(
      {super.key, required this.model, required this.categoryProductModel});

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends StateMVC<AllCategoriesScreen> {
  _AllCategoriesScreenState() : super(AllCategoriesController()) {
    con = AllCategoriesController();
  }
  late AllCategoriesController con;
  @override
  void initState() {
    super.initState();
    con.init(categoryIdd: widget.model?.id ??1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: widget.model?.title ?? "",
          icon: "",
        ),
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                sliver: PagedSliverGrid<int, CategoryProductModel>(
                  pagingController: con.pagingController,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 280, // Adjust as needed
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 0.8, // Adjust as needed
                  ),
                  builderDelegate:
                      PagedChildBuilderDelegate<CategoryProductModel>(
                    itemBuilder: (context, category, index) {
                      print("Category Length: ${con.pagingController.itemList?.length ?? 0}");
                      print("Attempting to access index: $index");
                      return CustomCategoryProductContainerWidget(
                          categoryProductModel: category,
                          addToCart: () {
                            print("heeeeeeeeeeel");
                          },
                          onFavoritePressed: () async {
                            print("Categories Length: ${con.pagingController.itemList?.length ?? 0}");
                            print("Attempting to access index: $index");


                            if (category.isFavorite == 0) {
                              if (SharedPref.getCurrentUser()?.token != null &&
                                  SharedPref.getCurrentUser()!
                                      .token!
                                      .isNotEmpty) {
                                await con.addToFavorite(
                                    context: context,
                                    product: category);
                                setState(() {
                                  category.isFavorite = 1;
                                });
                                //con.categories[index].isFavorite = 1;
                              } else {
                                con.unLoginWidget(context);
                              }
                            } else {
                              if (SharedPref.getCurrentUser()?.token != null &&
                                  SharedPref.getCurrentUser()!
                                      .token!
                                      .isNotEmpty) {
                                setState(() {
                                  category.isFavorite = 0;
                                });
                                // con.products[index].isFavorite = 0;
                                // con.deleteFavorite(productId: con.products[index].id??0);
                                ToastHelper.showSuccess(
                                  context: context,
                                  message: Strings.delete.tr,
                                  icon: SvgPicture.asset(
                                    Assets.imagesSubmit,
                                    width: 60.w,
                                    height: 50.h,
                                    fit: BoxFit.cover,
                                  ),
                                  backgroundColor:
                                      ThemeClass.of(context).primaryColor,
                                );
                              } else {
                                con.unLoginWidget(context);
                              }
                            }
                          }
                          // productsModel: PopularProductsModel(),
                          );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
