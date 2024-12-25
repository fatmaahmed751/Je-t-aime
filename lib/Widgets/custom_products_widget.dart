import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../generated/assets.dart';

class CustomProductsWidget extends StatelessWidget{
  const CustomProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
  return  Wrap(
    spacing: 12.w,
    runSpacing: 12.h,
    children: List.generate(10, (index) {
      return Container(
        height: 215.h,
        width: 175.w,
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.15),
          ),
          boxShadow: [
            BoxShadow(
                color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.15),
                blurRadius:1,
                spreadRadius: 0.5
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w ,vertical: 16.h),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Gap(40.w),
                  SizedBox(
                    height: 113.h,
                    width: 45.w,
                    child: Image.asset(
                      Assets.imagesProduct,
                      alignment: Alignment.center,
                      //  fit: BoxFit.cover,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          bottom:0.h
                      ),
                      child: SvgPicture.asset(Assets.imagesFavoriteIcon),
                    ),
                  ),
                ],
              ),
            ),
            Text(
                "Strawberry Body Butter",
                style: TextStyleHelper.of(context).b_14.copyWith(
                    color: ThemeClass.of(context).mainBlack
                )
            ),
            Expanded(
              child: Padding(
                padding:  EdgeInsetsDirectional.symmetric(
                    horizontal: 16.w) ,
                child: Row(
                  children: [
                    Text("350 JOD" ,
                      style: TextStyleHelper.of(context).h_16.copyWith(
                          color: ThemeClass.of(context).primaryColor
                      ),),
                    const Spacer(),
                    Container(
                      width: 28.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: ThemeClass.of(context).primaryColor,
                      ),
                      child:  Icon(Icons.add,
                        color: ThemeClass.of(context).background ,
                        size: 17,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    ),
  );
  }

}