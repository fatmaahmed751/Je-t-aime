import 'package:flutter/material.dart';
import "package:flutter_html/flutter_html.dart";
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.policy.tr,
          icon: "",
        ),
      ),
      // body: LoadingScreen(
      //   loading: con.loading,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
      //       child:SingleChildScrollView(
      //         child: Html(
      //             data:
      //
      //
      //             ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
