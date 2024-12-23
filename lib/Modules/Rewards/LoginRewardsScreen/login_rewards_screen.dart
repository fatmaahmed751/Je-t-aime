import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/shared_preferences.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../../Widgets/loading_screen.dart';
import '../../../Utilities/strings.dart';
import '../NotLoginHCRewards/not_login_rewards_row.dart';
import '../widget/login_hc_reward_widget.dart';
import '../widget/login_packages_rewards_widget.dart';
import 'login_reward_controller.dart';

class LoginRewardsScreen extends StatefulWidget {
  static const routeName = "LoginRewards";
  const LoginRewardsScreen({super.key});

  @override
  createState() => _LoginRewardsScreenState();
}

class _LoginRewardsScreenState extends StateMVC<LoginRewardsScreen> {
  _LoginRewardsScreenState() : super(LoginRewardsController()) {
    con = LoginRewardsController();
  }

  late LoginRewardsController con;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
      //     CustomAppBarWidget.mainDetailsScreen(screenName: Strings.rewards.tr, ),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 24.w, vertical: 10.h),
            child:con.isClick
                ? ListView(
                    children: [
                      Gap(7.h),
                      const NotLoginRewardsScreen(),
                    ],
                  )
                : ListView(
                    children: [
                      Gap(7.h),
                      toggleBetweenRewards(),
                      Gap(20.h),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.symmetric(
                      //     horizontal: 5.w,
                      //   ),
                      //   child: con.isClick
                      //       ? const HcRewardsLogin()
                      //       : const PackagesRewardsLogin(),
                      // ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget toggleBetweenRewards() => Container(
        decoration: BoxDecoration(
            color: ThemeClass.of(context).secondary,
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  con.isClick = !con.isClick;
                });
              },
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: 10.h, horizontal: 16.w),
                width: 180.w,
                height: 48.h,
                decoration: BoxDecoration(
                    color: con.isClick
                        ? ThemeClass.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(25)),
                clipBehavior: Clip.hardEdge,
                child: Text(
                  Strings.hcRewards.tr,
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.of(context).b_20.copyWith(
                      color: ThemeClass.of(context).mainBlack,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  con.isClick = !con.isClick;
                });
              },
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 10.w, vertical: 10.h),
                width: 180.w,
                height: 48.h,
                decoration: con.isClick
                    ? BoxDecoration(borderRadius: BorderRadius.circular(25))
                    : BoxDecoration(
                        color: ThemeClass.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(25)),
                clipBehavior: Clip.hardEdge,
                child: Text(
                  Strings.packages.tr,
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.of(context).b_20.copyWith(
                      color: ThemeClass.of(context).mainBlack,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ],
        ),
      );
}
