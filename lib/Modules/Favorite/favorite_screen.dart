import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Models/product_details_model.dart";
import 'package:je_t_aime/Widgets/custom_app_bar_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import "../../Utilities/shared_preferences.dart";
import '../../Utilities/strings.dart';
import '../../Widgets/bottom_navbar_widget.dart';
import '../../Widgets/container_empty_content_widget.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_products_widget.dart';
import '../../Widgets/loading_screen.dart';

import '../../generated/assets.dart';

import "../PopularProducts/popular_product_screen.dart";
import "../Register/register_screen.dart";
import 'favorite_controller.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = "FavoriteScreen";

  const FavoriteScreen({super.key});

  @override
  createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends StateMVC<FavoriteScreen> {
  _FavoriteScreenState() : super(FavoriteController()) {
    con = FavoriteController();
  }
  late FavoriteController con;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: con.isUserHaveFavorites
            ? PreferredSize(
                preferredSize: Size(double.infinity, 180.h),
                child: const CustomAppBarWidget.secondaryAppBar(
                  title: "", icon: "",
                  //controller: con.searchController,
                ))
            : const CustomAppBarWidget.mainScreen(
                title: "",
                icon: "",
              ),
        bottomNavigationBar: const BottomNavBarWidget(
          selected: SelectedBottomNavBar.favorite,
        ),
        body: LoadingScreen(
          loading: con.loading,
          child: SafeArea(
            child: con.products.isEmpty
                ? Padding(
                  padding: EdgeInsetsDirectional.only(top: 60.h),
                  child: ContainerEmptyContentWidget(
                    image: Assets.imagesNoFavoriteProduct,
                    mainText: Strings.noFavorites.tr,
                    descText: Strings.noFavoritesDesc.tr,
                    button: CustomButtonWidget.primary(
                        height: 48.h,
                        width: 155.w,
                        radius: 30.r,
                        title:
                            SharedPref.getCurrentUser()!.token!.isNotEmpty
                                ? Strings.exploreProduct.tr
                                : Strings.joinUs.tr,
                        onTap: () {
                          SharedPref.getCurrentUser()!.token!.isNotEmpty
                              ? GoRouter.of(context).pushNamed(
                                  PopularProductsScreen.routeName,
                                )
                              : GoRouter.of(context)
                                  .pushNamed(RegisterScreen.routeName);
                        }),
                  ),
                )
                : Expanded(
                    child: PagedListView<int, PopularProductsModel>(
                      physics: const BouncingScrollPhysics(),
                      pagingController: con.pagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<PopularProductsModel>(
                        itemBuilder: (context, item, index) {
                          return CustomProductsWidget(model: item);
                        },
                        firstPageProgressIndicatorBuilder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        newPageProgressIndicatorBuilder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
          ),
        ),
    );
  }
}
