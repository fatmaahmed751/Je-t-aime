import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Modules/Home/Widgets/search_widget.dart";
import "package:je_t_aime/Modules/PopularProducts/popular_products_controller.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../Utilities/shared_preferences.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/custom_app_bar_widget.dart";
import "../../Widgets/loading_screen.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../AllCategories/widget/category_product_widget.dart";
import "Widgets/custom_product_container_widget.dart";

class PopularProductsScreen extends StatefulWidget {
  static const routeName = "PopularProduct";
  //final PopularProductsModel productsModel;
  final List<PopularProductsModel> products;
  const PopularProductsScreen({super.key, required this.products});

  @override
  PopularProductsScreenState createState() => PopularProductsScreenState();
}

class PopularProductsScreenState extends StateMVC<PopularProductsScreen> {
  PopularProductsScreenState() : super(PopularProductController()) {
    con = PopularProductController();
  }
  late PopularProductController con;

  @override
  void initState() {
    con.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.products.tr,
          icon: "",
        ),
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
              //physics: NeverScrollableScrollPhysics(),
              //padding: EdgeInsets.zero,
              children: [
                Row(
                  children: [
                    SearchWidget(
                        width: 300.w,
                        backGroundColor: ThemeClass.of(context)
                            .secondary
                            .withAlpha((1 * 255).toInt()),
                        onSearch: (String? text) {},
                        isSearch: true,
                        controller: con.searchController,
                        onRemove: () {},
                        onChange: (String? value) {}),
                    Gap(10.w),
                    GestureDetector(
                        onTap: () {
                          con.filterBottomSheet(context);
                        },
                        child: SvgPicture.asset(Assets.imagesFilterIcon))
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: CustomScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          sliver: PagedSliverGrid<int, PopularProductsModel>(
                            pagingController: con.pagingController,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 280, // Adjust as needed
                              mainAxisSpacing: 12.h,
                              crossAxisSpacing: 12.w,
                              childAspectRatio: 0.8, // Adjust as needed
                            ),
                            builderDelegate:
                                PagedChildBuilderDelegate<PopularProductsModel>(
                              itemBuilder: (context, item, index) {
                                return CustomProductContainerWidget(
                                  addToCart: () async {
                                    final isProductInCart =
                                        await con.isProductInCart(item.id ?? 0);

                                    if (isProductInCart) {
                                      // Product is already in the cart, show a message
                                      ToastHelper.showError(
                                          message: Strings.productInCart.tr);
                                      return;
                                    } else {
                                      con.addProductToCart(
                                          context: context,
                                          product: con.products[index]);
                                    }
                                  },
                                  productsModel: item,
                                  onFavoritePressed: () async {
                                    if (con.products[index].isFavorite == 0) {
                                      if (SharedPref.getCurrentUser()?.token !=
                                              null &&
                                          SharedPref.getCurrentUser()!
                                              .token!
                                              .isNotEmpty) {
                                        await con.addToFavorite(
                                            context: context,
                                            product: con.products[index]);
                                        setState(() {
                                          con.products[index].isFavorite = 1;
                                        });
                                        //con.products[index].isFavorite = 1;
                                      } else {
                                        con.unLoginWidget(context);
                                      }
                                    } else {
                                      if (SharedPref.getCurrentUser()?.token !=
                                              null &&
                                          SharedPref.getCurrentUser()!
                                              .token!
                                              .isNotEmpty) {
                                        setState(() {
                                          con.products[index].isFavorite = 0;
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
                                              ThemeClass.of(context)
                                                  .primaryColor,
                                        );
                                      } else {
                                        con.unLoginWidget(context);
                                      }
                                    }
                                  },
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
              ]),
        ),
      ),
    );
  }
}
