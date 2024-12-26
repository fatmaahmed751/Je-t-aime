import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Widgets/custom_side_text_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/shared_preferences.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../../Widgets/loading_screen.dart';
import '../../../Utilities/strings.dart';
import '../../../Widgets/container_empty_content_widget.dart';
import '../../../Widgets/custom_app_bar_widget.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_details_side_text.dart';
import '../../../generated/assets.dart';
import '../widgets/earn_points_widget.dart';
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
      appBar: CustomAppBarWidget.detailsScreen(
        title: Strings.rewards.tr,
        icon: "",
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
            child: ListView(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    SvgPicture.asset(
                      Assets.imagesContainer,
                      height: 130.h,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDetailsSideTextWidget(
                              text: Strings.loyaltyPoints.tr),
                          Gap(8.h),
                          Text(
                            "0 ${Strings.points.tr}",
                            textAlign: TextAlign.left,
                            style: TextStyleHelper.of(context).b_16.copyWith(
                                color: ThemeClass.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(24.h),
                CustomDetailsSideTextWidget(text: Strings.transactions.tr),
                Gap(16.h),
                con.isClick
                    ? SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: ListView.separated(
                          itemBuilder: (context, index) => const EarnPoints(),
                          itemCount: 10,
                          separatorBuilder: (context, index) => Gap(5.h),
                        ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Gap(70.h),
                            Text(
                              Strings.noTransactionYet.tr,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyleHelper.of(context).b_16.copyWith(
                                  color: ThemeClass.of(context)
                                      .secondaryBlackColor),
                            ),
                            Gap(40.h),
                            Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 40.w),
                              child: CustomButtonWidget.primary(
                                  height: 48.h,
                                  width: 150.w,
                                  radius: 30.r,
                                  title: Strings.exploreProduct.tr,
                                  onTap: () {
                                    // GoRouter.of(context)
                                    //     .pushNamed(RegisterScreen.routeName);
                                  }),
                            ),
                          ]),
              ],
            ),
          ),
          // const NotLoginRewardsWidget()
        ),
      ),
    );
  }
}
