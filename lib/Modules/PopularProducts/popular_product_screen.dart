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
      appBar: PreferredSize(
        preferredSize: Size(0,75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.products.tr,
          icon: "",
        ),
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:15.w),
          child: ListView(
            padding: EdgeInsets.zero,
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
                  GestureDetector(
                    onTap: (){
con.filterBottomSheet(context);
                    },
                      child: SvgPicture.asset(Assets.imagesFilterIcon))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Wrap(
                  spacing: 12.w,
                  runSpacing:12.h,
                  children: List.generate(10, (index) {
                    return const CustomProductContainerWidget();
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
