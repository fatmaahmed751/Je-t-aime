import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../Utilities/strings.dart';
import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';
import '../Utilities/validate.dart';
import '../generated/assets.dart';
import 'custom_app_bar_text_widget.dart';
import 'custom_textfield_widget.dart';

Widget buildPreferredSize(BuildContext context) {
  return SizedBox(
    // height: 400.h,
    child: Stack(
      children: [
        Container(
          height: 280.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ThemeClass.backgroundGradiant,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
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
            padding:
                EdgeInsetsDirectional.only(start: 10.w, top: 50.h, end: 10.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //const SizedBox(width: 15,),

                    CustomAppBarMainTextWidget(text: Strings.hello.tr),
                    Gap(8.w),
                    Image.asset(
                      Assets.imagesFace,
                      width: 24.w,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
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
                      onTap: () {},
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
                CustomTextFieldWidget(
                  height: 48.h,
                  insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                  borderRadiusValue: 30.r,
                  isDense: true,
                  prefixIcon: SvgPicture.asset(Assets.imagesSearch),
                  hint: Strings.searchHere.tr,
                  backGroundColor: ThemeClass.of(context).background,
                  //controller:controller,
                  hintStyle: TextStyleHelper.of(context)
                      .b_16
                      .copyWith(color: ThemeClass.of(context).labelColor),
                  validator: (v) => Validate.validateEmail(v),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
