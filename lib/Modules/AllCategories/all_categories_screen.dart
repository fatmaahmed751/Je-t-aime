import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Utilities/strings.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_product_container_widget.dart';
import '../../Widgets/loading_screen.dart';
import '../PopularProducts/popular_product_screen.dart';
import 'all_categories_controller.dart';
class AllCategoriesScreen extends StatefulWidget {
  static const routeName = "AllCategoriesScreen";
  const AllCategoriesScreen({super.key});

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
    // TODO: implement initState
    con.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(
    title: Strings.hairCare.tr,
      icon: "",
    ),
      body:LoadingScreen(
        loading: con.loading,
        color: Colors.transparent,
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children:List.generate(10, (index) {
              return GestureDetector(
                  onTap: () => context.pushNamed(PopularProductsScreen.routeName),
                  child: const CustomProductContainerWidget());
            }),
          ),
        ),
      ),
    );
  }
}