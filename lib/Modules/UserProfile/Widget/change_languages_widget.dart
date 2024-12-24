import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import '../../../../Utilities/strings.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../../core/Language/app_languages.dart';
import '../../../../generated/assets.dart';
import '../user_profile_controller.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends StateMVC<ChangeLanguage> {
  _ChangeLanguageState() : super(UserProfileController()) {
    con = UserProfileController();
  }

  late UserProfileController con;
  @override
  void initState() {
    super.initState();
    con.loadCurrentLanguage(context);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 382.w,
        height: 200.h,
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
          child: Card(
            elevation: 0.0,
            color: ThemeClass.of(context).background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(15.h),
                // Row(
                //   children: [
                //     IconButton(
                //       icon: con.selectedLanguage == 1
                //           ? SvgPicture.asset(Assets.imagesFilledRadioIcon)
                //           : SvgPicture.asset(Assets.imagesLightRadioIcon),
                //       onPressed: () {
                //         // setState(
                //           () {
                //             con.selectLanguage(1);
                //             Provider.of<AppLanguage>(context, listen: false)
                //                 .changeLanguage(language: Languages.en);
                //             context.pop();
                //           },
                //         );
                //       },
                //     ),
                //     Text(
                //       Strings.english.tr,
                //       style: TextStyleHelper.of(context)
                //           .b_16
                //           .copyWith(color: ThemeClass.of(context).mainBlack),
                //     ),
                //   ],
                // ),
                // Gap(10.h),
                // Row(
                //   children: [
                //     IconButton(
                //       icon: con.selectedLanguage == 2
                //           ? SvgPicture.asset(Assets.imagesFilledRadioIcon)
                //           : SvgPicture.asset(Assets.imagesLightRadioIcon),
                //       onPressed: () {
                //         setState(
                //           () {
                //             con.selectLanguage(2);
                //             Provider.of<AppLanguage>(context, listen: false)
                //                 .changeLanguage(language: Languages.ar);
                //             context.pop();
                //           },
                //         );
                //       },
                //     ),
                //     Text(
                //       Strings.arabic.tr,
                //       style: TextStyleHelper.of(context)
                //           .b_16
                //           .copyWith(color: ThemeClass.of(context).mainBlack),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
