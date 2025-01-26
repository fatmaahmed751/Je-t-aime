import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/AllCategories/all_categories_screen.dart';
import 'package:je_t_aime/Utilities/text_style_helper.dart';
import 'package:je_t_aime/Utilities/theme_helper.dart';
import '../../../Models/category_model.dart';
import '../../../Widgets/custom_home_details_text_widget.dart';

class CategoriesWidget extends StatelessWidget{
  final CategoryModel categoryModel;

  const CategoriesWidget({super.key, required this.categoryModel});
  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      width: 104.w,
      height: 136.h,
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              context.pushNamed(AllCategoriesScreen.routeName);
            },
            child: CircleAvatar(
              radius:50.r,
              backgroundImage:
              AssetImage(
                  categoryModel.image!),),
          ),
          Gap(6.h),
          CustomHomeDetailsTextWidget(text:categoryModel.title!,
            style: TextStyleHelper.of(context).b_16.copyWith(
              color: ThemeClass.of(context).mainBlack,
              fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}