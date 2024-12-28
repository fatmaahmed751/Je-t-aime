import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../Models/category_model.dart';
import '../../../Widgets/custom_side_text_widget.dart';

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
          CircleAvatar(
            radius:50.r,
            backgroundImage:
            NetworkImage(
                categoryModel.imageName ),),
          Gap(6.h),
          CustomSideTextWidget(text:categoryModel.mainText )
        ],
      ),
    );
  }

}