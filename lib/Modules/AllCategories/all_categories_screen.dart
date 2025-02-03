import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:je_t_aime/Models/category_model.dart";
import "package:je_t_aime/Modules/AllCategories/widget/category_product_widget.dart";
import "package:mvc_pattern/mvc_pattern.dart";

import "../../Models/categories_product_model.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/custom_app_bar_widget.dart";
import "../../Widgets/loading_screen.dart";
import "../../generated/assets.dart";
import "../Home/Widgets/search_widget.dart";
import "all_categories_controller.dart";

class AllCategoriesScreen extends StatefulWidget {
  static const routeName = "AllCategoriesScreen";
  final CategoryModel model;
  final CategoryProductModel categoryProductModel;
  const AllCategoriesScreen({super.key, required this.model, required this.categoryProductModel});

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
    con.init(
      categoryModel: widget.model
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title:widget.model.title??"",
          icon: "",
        ),
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: Visibility(
    visible:con.categoryProducts.data.isEmpty,
          replacement: const Center(child: SizedBox()),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ListView(
                physics: const BouncingScrollPhysics(),
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
                    padding:EdgeInsets.symmetric(vertical: 24.h),
                    child: Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children:con.categoryProducts.data.map((e) {
                        return CustomCategoryProductContainerWidget(categoryProductModel:widget.categoryProductModel,);
                      }).toList(),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
