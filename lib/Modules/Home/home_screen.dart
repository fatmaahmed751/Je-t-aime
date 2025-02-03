import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/PopularProducts/popular_product_screen.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/bottom_navbar_widget.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_details_side_text.dart';
import '../../Widgets/custom_product_container_widget.dart';
import '../../Widgets/loading_screen.dart';
import 'Widgets/categories_widget.dart';
import 'Widgets/packages_widget.dart';
import 'home_screen_controller.dart';

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

//     HomeController().controller.addListener(_updateView);
// }
//   @override
//   void dispose() {
//     // Remove the listener when the screen is disposed
//     HomeController().controller.removeListener(_updateView);
//     super.dispose();
//   }
//   void _updateView() {
//     // Define what should happen when the controller state changes
//     setState(() {
//       // Update the UI or trigger some action here
//     });
//
//   }
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    // print(SharedPref.getCurrentUser()?.token);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 180.h),
          child: const CustomAppBarWidget.secondaryAppBar(
            title: "",
            icon: "",
          )),
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
          child: ListView(
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
                      onTap: () =>
                          context.pushNamed(PopularProductsScreen.routeName),
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
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 5.h),
                            child: CustomProductContainerWidget(
                              productsModel: con.products[index],
                            ),
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
