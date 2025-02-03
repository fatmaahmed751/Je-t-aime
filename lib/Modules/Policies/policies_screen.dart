import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Modules/Policies/policies_controller.dart';
import 'package:je_t_aime/Utilities/theme_helper.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Widgets/loading_screen.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_details_side_text.dart';

class PoliciesScreen extends StatefulWidget {
  static const routeName = "Policies";
  // final PoliciesModel? policiesModel;
  const PoliciesScreen({
    super.key,
    // this.policiesModel
  });

  @override
  createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends StateMVC<PoliciesScreen> {
  _PoliciesScreenState() : super(PoliciesController()) {
    con = PoliciesController();
  }

  late PoliciesController con;

  @override
  void initState() {
    super.initState();
    con.init();
  }

  @override
  Widget build(BuildContext context) {
    // print("UI Model Privacy Policy: ${con.policiesModel?.privacyPolicy ??
    //     'UI has no data'}");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.policy.tr,
          icon: "",
        ),
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDetailsSideTextWidget(
                      text: Strings.shippingPolicy.tr,
                    ),
                    Gap(10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 6.0,
                          color: Colors.black,
                        ),
                        Gap(8.w),
                        Expanded(
                          child: Text(
                            Strings.shippingPolicyDes.tr,
                            style: TextStyleHelper.of(context).b_16.copyWith(
                                  color: ThemeClass.of(context).descTextColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Gap(10.h),
                    CustomDetailsSideTextWidget(
                      text: Strings.privacyPolicy.tr,
                    ),
                    Gap(10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 6.0,
                          color: Colors.black,
                        ),
                        Gap(8.w),
                        Expanded(
                          child: Text(
                            Strings.privacyPolicyDesc.tr,
                            style: TextStyleHelper.of(context).b_16.copyWith(
                                  color: ThemeClass.of(context).descTextColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Gap(10.h),
                    CustomDetailsSideTextWidget(
                        text: Strings.customerSupport.tr),
                    Gap(10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 6.0,
                          color: Colors.black,
                        ),
                        Gap(8.w),
                        Expanded(
                          child: Text(
                            Strings.customerSupportDesc.tr,
                            style: TextStyleHelper.of(context).b_16.copyWith(
                                  color: ThemeClass.of(context).descTextColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
