import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
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
import "../../generated/assets.dart";
import "Widgets/custom_product_container_widget.dart";

class PopularProductsScreen extends StatefulWidget {
  static const routeName = "PopularProduct";
  //final PopularProductsModel productsModel;
  final List<PopularProductsModel> products;
  const PopularProductsScreen({super.key, required this.products, });

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
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Row(
                children: [
                  SearchWidget(
                      width: 300.w,
                      backGroundColor:
                          ThemeClass.of(context).secondary.withOpacity(1),
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: con.products.isNotEmpty
                  ? List.generate(
                con.products.length,
                    (index) {
                  return CustomProductContainerWidget(
                    productsModel: con.products[index],
                    onFavoritePressed: () {
                      if (SharedPref.getCurrentUser()?.token != null &&
                          SharedPref.getCurrentUser()!.token!.isNotEmpty) {
                        setState(() {
                          // إنشاء نسخة جديدة مع تحديث isFavorite
                          con.products[index] = con.products[index].copyWith(
                            isFavorite: con.products[index].isFavorite == 0 ? 1 : 0,
                          );
                        });

                        if (con.products[index].isFavorite == 1) {
                          con.addFavorite(productId: con.products[index].id ?? 0);
                        } else {
                          con.deleteFavorite(productId: con.products[index].id ?? 0);
                        }
                      } else {
                        // إذا لم يكن المستخدم مسجل الدخول، قم بإظهار رسالة أو نافذة تسجيل دخول
                        // con.unLoginForRatedPop(context);
                      }
                    },
                  );
                },
              )
                  : [],
            ),
          ),

        ]
      ),
    ),
      ),
    );
  }
}
