import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Modules/PopularProducts/popular_product_screen.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../Models/popular_products_model.dart";
import "../../Utilities/shared_preferences.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/text_style_helper.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/bottom_navbar_widget.dart";
import "../../Widgets/custom_app_bar_text_widget.dart";
import "../../Widgets/custom_app_bar_widget.dart";
import "../../Widgets/custom_details_side_text.dart";
import "../../Widgets/loading_screen.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../Cart/cart_screen.dart";
import "../PopularProducts/Widgets/custom_product_container_widget.dart";
import "../Rewards/LoginRewardsScreen/login_rewards_screen.dart";
import "SearchSccreen/search_screen.dart";
import "Widgets/categories_widget.dart";
import "Widgets/packages_widget.dart";
import "Widgets/search_widget.dart";
import "home_screen_controller.dart";

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends StateMVC<HomeScreen> {
  _HomeScreenState() : super(HomeController()) {
    con = HomeController();
  }
  late HomeController con;
  @override
  void initState() {
    con.init();
    super.initState();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    String? token = SharedPref.getCurrentUser()?.token; // Get saved token

    if (token == null || token.isEmpty) {
      print("⚠️ Error: Missing Authentication Token");
    }
    print(token);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 180.h),
        child: SizedBox(
          child: Stack(
            children: [
              Container(
                // height:500.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: SharedPref.getCurrentLanguage() == "ar"
                        ? ThemeClass.anotherBackGround
                        : ThemeClass.backgroundGradiant,
                    end: Alignment.centerRight,
                    begin: Alignment.centerLeft,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 24.w, top: 60.h, end: 24.w),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //const SizedBox(width: 15,),

                        CustomAppBarMainTextWidget(text: Strings.hello.tr),
                        Gap(8.w),
                        Image.asset(
                          Assets.imagesFaceSmile,
                          width: 24.w,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(LoginRewardsScreen.routeName);
                          },
                          child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                  color: ThemeClass.of(context).background,
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 6.w, vertical: 6.h),
                                child: SvgPicture.asset(
                                  Assets.imagesRewards,
                                ),
                              )),
                        ),
                        Gap(8.w),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(CartScreen.routeName);
                          },
                          child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                  color: ThemeClass.of(context).background,
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 6.w, vertical: 6.h),
                                child: SvgPicture.asset(
                                  Assets.imagesShop,
                                ),
                              )),
                        ),
                      ],
                    ),
                    Gap(30.h),
                    SearchWidget(
                        width: 382.w,
                        backGroundColor: ThemeClass.of(context).background,
                        onSearch: (String? text) {
                          if (text != null) {
                            setState(() {
                              con.isSearch = true;
                              con.onSearchReq(text);
                            //   context.pushNamed(SearchScreen.routeName,
                            //       extra: text);
                            });
                         }
                        },
                        isSearch: con.isSearch,
                        controller: con.searchController,
                        onRemove: () {
                          setState(() {
                            con.searchController.clear();
                            con.isSearch = false;
                          });
                        },
                        onChange: (text) {
                          if (text != null) {
                            setState(() {
                              con.isSearch = true;
                            });
                          }
                        }),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarWidget(
        selected: SelectedBottomNavBar.home,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // con.init();
        },
        child: LoadingScreen(
          loading: con.loading,
          color: Colors.transparent,
          child:con.isSearch? con.isSearch
              ? ListView.builder(
            itemCount: con.searchModels.length,
            itemBuilder: (context, index) {
              final item = con.searchModels[index];
              return ListTile(
                title: Text(item.title??""),
                subtitle: Text(item.price.toString()),
              );
            },
          )
              : Center(child: Text("No search results"))
              : ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Gap(16.h),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 18.w),
                child: CustomDetailsSideTextWidget(
                  text: Strings.categories.tr,
                ),
              ),
              Gap(16.h),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 12.w),
                child: SizedBox(
                  height: 150.h,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoriesWidget(
                            categoryModel: con.categories[index],
                          ),
                      separatorBuilder: (context, index) => Gap(6.w),
                      itemCount: con.categories.length),
                ),
              ),
              Gap(10.h),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: SizedBox(
                  height: 200.h,
                  // width: MediaQuery.sizeOf(context).width,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => PackagesWidget(
                            sliderModel: con.sliders[index],
                          ),
                      separatorBuilder: (context, index) => Gap(14.w),
                      itemCount: con.sliders.length),
                ),
              ),
              Gap(16.h),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDetailsSideTextWidget(
                      text: Strings.popularProduct.tr,
                    ),
                    InkWell(
                      onTap: () async {
                        if (con.products.isEmpty) {
                          print("impty${con.products}");
                        }
                        if (con.products.isNotEmpty) {
                          await context.pushNamed(
                              PopularProductsScreen.routeName,
                              extra: con.products);
                        }
                      },
                      child: Text(
                        Strings.viewAll.tr,
                        style: TextStyleHelper.of(context).b_16.copyWith(
                            decoration: TextDecoration.underline,
                            color: ThemeClass.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(16.h),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: SizedBox(
                  height: 230.h,
                  child: con.products.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    vertical: 5.h),
                                child: CustomProductContainerWidget(
                                    addToCart: () {
                                      con.addProductToCart(
                                          context: context,
                                          product: con.products[index]);
                                    },
                                    productsModel: con.products[index],
                                    onFavoritePressed: () async {
                                      if (con.products[index].isFavorite == 0) {
                                        if (SharedPref.getCurrentUser()
                                                    ?.token !=
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
                                        if (SharedPref.getCurrentUser()
                                                    ?.token !=
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
                                    }),
                              ),
                          separatorBuilder: (context, index) => Gap(10.w),
                          itemCount: con.products.length),
                ),
              ),
              Gap(20.h)
            ],
          ),
        ),
      ),
    );
  }
}
