import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/ForgetPassword/forget_password_screen.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../Models/on_boarding_model.dart';
import '../../Login/login_screen.dart';
import '../onboarding_controller.dart';

class OnBoardingWidget extends StatelessWidget {
  final OnBoardingModel model;
  const OnBoardingWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(top: 30.h),
          child: Align(
            alignment: Alignment.topRight,
            child: TextButton(
                onPressed: () {
                GoRouter.of(context).goNamed(ForgetPasswordScreen.routeName);
                },
                child: Text(
                  model.skipText,
                  style: TextStyleHelper.of(context).b_16.copyWith(
                      color: ThemeClass.of(context).secondaryBlackColor),
                )),
          ),
        ),
        Gap(model.id == 0 ? 100.h : 24.h),
        Center(
          child: Image.asset(
            model.imageName,
            width: model.id == 0 ? 212.w : 382.w,
            height: model.id == 0 ? 268.h : 463.h,
          ),
        ),
        Gap(model.id == 0 ? 100.h : 24.h),

        Center(
          child: Text(
            textAlign: TextAlign.center,
            model.mainText,
            style: TextStyleHelper.of(context)
                .h_20
                .copyWith(color: ThemeClass.of(context).mainBlack),
          ),
        ),
        Gap(15.h),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
          child: Text(
            textAlign: TextAlign.center,
            model.subText,
            style: TextStyleHelper.of(context)
                .b_16
                .copyWith(color: ThemeClass.of(context).secondaryBlackColor),
          ),
        ),

      ],
    );
  }
}
