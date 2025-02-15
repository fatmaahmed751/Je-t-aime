import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/ForgetPassword/forget_password_screen.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../Models/on_boarding_model.dart';
import "../../../Utilities/shared_preferences.dart";
import '../../Home/home_screen.dart';
import '../../Login/login_screen.dart';
import '../onboarding_controller.dart';

class OnBoardingWidget extends StatelessWidget {
  final OnBoardingModel model;
  const OnBoardingWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(top: 0.h),
          child: Align(
            alignment: Alignment.topRight,
            child: TextButton(
                onPressed: () {
                  GoRouter.of(context).goNamed(HomeScreen.routeName);
                  if(!SharedPref.isLogin()){
                    SharedPref.prefs.clear();
                  }
                },
                child: Text(
                  model.skipText,
                  style: TextStyleHelper.of(context).b_16.copyWith(
                      color: ThemeClass.of(context).secondaryBlackColor),
                )),
          ),
        ),
        Gap(model.id == 0 ? 100.h : 20.h),
        Center(
          child: Image.asset(
            model.imageName,
            width: model.id == 0 ? 212.w : 382.w,
            height: model.id == 0 ? 268.h : 455.h,
          ),
        ),
        Gap(model.id == 0 ? 90.h : 30.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the container
            boxShadow: [
              BoxShadow(
                color:
                    const Color(0xff33333326).withAlpha((0.13 * 255).toInt()), // Shadow color
                spreadRadius: 0, // Spread radius
                blurRadius: 1, // Blur radius for a soft shadow
                offset: const Offset(
                    0, -1), // Negative offset to place shadow on top
              ),
            ],
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(model.id == 0 ? 35.h : 20.h),
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
                  style: TextStyleHelper.of(context).b_16.copyWith(
                      color: ThemeClass.of(context).secondaryBlackColor),
                ),
              ),
              Gap(5.h)
            ],
          ),
        ),
      ],
    );
  }
}
