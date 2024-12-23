
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../../../../Utilities/strings.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../../Widgets/custom_button_widget.dart';

class UserLogOutDialog extends StatelessWidget {
  const UserLogOutDialog({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        width: 382.w,
        height: 204.h,
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.confirmLogout.tr,
                style: TextStyleHelper
                    .of(context)
                    .h_20
                    .copyWith(
                  color: ThemeClass
                      .of(context)
                      .mainBlack,
                  decoration: TextDecoration.none,
                ),
              ),
              Gap(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonWidget.secondary(
                    width: 148.w,
                    title: Strings.cancel.tr,
                    onTap: ()=>context.pop(),
                    textStyle: TextStyleHelper.of(context).h_20.
                    copyWith(color: ThemeClass.of(context).primaryColor),
                  ),
                  Gap(16.w),
                  CustomButtonWidget.primary(
                    width: 148.w,
                    title: Strings.yes.tr,
                    textStyle: TextStyleHelper.of(context).h_20.copyWith(
                      color:
                      ThemeClass.of(context).mainBlack,
                    ),
                  //  onTap:()=>
                       // GoRouter.of(context).pushNamed(RegisterScreen.routeName),

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}