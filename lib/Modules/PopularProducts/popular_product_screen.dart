import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Modules/Home/Widgets/search_widget.dart';
import 'package:je_t_aime/Modules/PopularProducts/popular_products_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_product_container_widget.dart';
import '../../Widgets/loading_screen.dart';
import '../../generated/assets.dart';

class PopularProductsScreen extends StatefulWidget {
  static const routeName = "PopularProduct";
  const PopularProductsScreen({super.key});

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(
        title: Strings.products.tr,
        icon: "",
      ),
      body: LoadingScreen(
        loading: con.loading,
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                SearchWidget(
                    onSearch: (String? text) {},
                    isSearch: true,
                    controller: con.searchController,
                    onRemove: () {},
                    onChange: (String? value) {}),
                Gap(10.w),
                SvgPicture.asset(Assets.imagesFilterIcon)
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: List.generate(10, (index) {
                  return const CustomProductContainerWidget();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
