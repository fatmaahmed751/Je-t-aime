import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Modules/Policies/policies_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Widgets/loading_screen.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Widgets/custom_app_bar_widget.dart';

class PoliciesScreen extends StatefulWidget {
  static const routeName = "Policies";
 // final PoliciesModel? policiesModel;
   const PoliciesScreen({super.key,
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

    print("UI Model Privacy Policy: ${con.policiesModel?.privacyPolicy ??
        'UI has no data'}");
    return Scaffold(
      // appBar:
      // CustomAppBarWidget.mainDetailsScreen(screenName: Strings.policy.tr,),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 24.w, vertical: 10.h),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.privacyPolicies.tr,
                      style: TextStyleHelper
                          .of(context)
                          .b_20
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Gap(10.h),
                    Text(
                      Strings.informationCollect.tr,
                      style: TextStyleHelper
                          .of(context)
                          .b_16
                          .copyWith(
                        color: const Color(0xff635D59),
                      ),
                    ),
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
                            con.policiesModel?.privacyPolicy ?? "Information not available",
                              style:
                                  TextStyleHelper.of(context).b_14.copyWith(
                                        color: const Color(0xff635D59),

                                      ),

                          ),
                        ),
                      ],
                    ),
                    Text(Strings.qualityPolicy.tr,
                        style: TextStyleHelper
                            .of(context)
                            .b_20
                            .copyWith(fontWeight: FontWeight.w500
                        )),
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
