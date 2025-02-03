import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/OnBoarding/widgets/on_boarding_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/custom_button_widget.dart';
import '../Login/login_screen.dart';
import 'onboarding_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = "OnBoarding";

  const OnBoardingScreen({super.key});

  @override
  createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends StateMVC<OnBoardingScreen> {
  _OnBoardingScreenState() : super(OnBoardingController()) {
    con = OnBoardingController();
  }

  late OnBoardingController con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: con.controller,
              onPageChanged: (int index) {
                setState(() {
                  con.index = index;
                  con.isLast = index == con.onBoarding.length - 1;
                });
              },
              itemBuilder: (context, index) => OnBoardingWidget(
                model: con.onBoarding[index],
              ),
              itemCount: con.onBoarding.length,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 20.h),
            child: SmoothPageIndicator(
              controller: con.controller, // PageController
              count: con.onBoarding.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8.h,
                dotWidth: 20.r,
                spacing: 8.0,
                activeDotColor: ThemeClass.of(context).primaryColor,
                dotColor: ThemeClass.of(context).labelColor,
              ),
            ),
          ),
          if (con.isLast)
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
              child: CustomButtonWidget.primary(
                  height: 54.h,
                  title: Strings.getStarted.tr,
                  textStyle: TextStyleHelper.of(context)
                      .h_16
                      .copyWith(color: ThemeClass.of(context).background),
                  radius: 30.r,
                  onTap: () {
                    GoRouter.of(context).goNamed(LoginScreen.routeName);
                  }),
            ),
          // Gap(10.h),
          if (!con.isLast)
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
              child: CustomButtonWidget.primary(
                  title: Strings.next.tr,
                  height: 54.h,
                  textStyle: TextStyleHelper.of(context)
                      .h_16
                      .copyWith(color: ThemeClass.of(context).background),
                  radius: 30.r,
                  onTap: () {
                    con.onNext();
                    // GoRouter.of(context).goNamed(LoginScreen.routeName);

                    //  con.onNext();
                  }),
            ),
          Gap(40.h),
        ],
      ),
    );
  }
}
