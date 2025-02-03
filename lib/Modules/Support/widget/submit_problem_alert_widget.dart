import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import '../../../../Utilities/strings.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../../Widgets/custom_button_widget.dart';
import '../../../../generated/assets.dart';

class AlertSubmitProblemSuccessfully extends StatelessWidget {
  const AlertSubmitProblemSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 373.w,
        height: 690.h,
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 30.w, vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   Assets.imagesConfirmData,
              //   width: 325.w,
              //   height: 314.h,
              // ),
              Text(
                textAlign: TextAlign.center,
                maxLines: 2,
                Strings.sendingProblem.tr,
                style: TextStyleHelper.of(context).h_20.copyWith(
                      decoration: TextDecoration.none,
                    ),
              ),
              Gap(10.h),
              Text(Strings.thanksForTrust.tr,
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.of(context).b_16.copyWith(
                      decoration: TextDecoration.none,
                      color: const Color(0xff968F8A))),
              Gap(20.h),
              Card(
                color: Colors.white,
                elevation: 0.0,
                child: CustomButtonWidget.primary(
                    title: Strings.send.tr,
                    onTap: () {
                      // GoRouter.of(context).pushNamed(
                      //     HomeScreen.routeName);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
