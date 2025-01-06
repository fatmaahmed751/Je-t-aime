import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';
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
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    con.loadCurrentLanguage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 382.w,
      // height: 200.h,
      decoration: BoxDecoration(
        color: ThemeClass.of(context).background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Padding(
        padding:
            EdgeInsetsDirectional.symmetric( vertical: 35.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric( horizontal: 20.w),
              child: Text(Strings.languages.tr ?? '',
                  style: TextStyleHelper.of(context).h_20.copyWith(
                      color: ThemeClass.of(context).mainBlack,
                      fontWeight: FontWeight.w500)),
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: con.selectedLanguage == 1
                      ? SvgPicture.asset(Assets.imagesSelectedIcon)
                      : SvgPicture.asset(Assets.imagesUnSelectedIcon),
                  onPressed: () {
                    setState(() {
                        con.selectLanguage(1);
                      },
                    );
                  },
                ),
                Text(
                  Strings.english.tr,
                  style: TextStyleHelper.of(context)
                      .b_16
                      .copyWith(color: ThemeClass.of(context).mainBlack),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: con.selectedLanguage == 2
                      ? SvgPicture.asset(Assets.imagesSelectedIcon)
                      : SvgPicture.asset(Assets.imagesUnSelectedIcon),
                  onPressed: () {
                    setState(() {
                        con.selectLanguage(2);
                      },
                    );
                  },
                ),
                Text(
                  Strings.arabic.tr,
                  style: TextStyleHelper.of(context)
                      .b_16
                      .copyWith(color: ThemeClass.of(context).mainBlack),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric( horizontal: 16.w),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: 170.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ThemeClass.of(context).secondary),
                          borderRadius: BorderRadius.circular(30.r),
                          color: ThemeClass.of(context).secondary
                          // ThemeClass.of(context).background.withOpacity(0.20)
                          ),
                      //  backgroundColor: ThemeClass.of(context).primaryColor,
                      child: Center(
                        child: Text(
                          Strings.cancel.tr,
                          style: TextStyleHelper.of(context).h_16.copyWith(
                              color: ThemeClass.of(context).secondaryBlackColor),
                        ),
                      ),
                    ),
                  ),
                  Gap(16.w),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (con.selectedLanguage == 1) {
                          Provider.of<AppLanguage>(context, listen: false)
                              .changeLanguage(language: Languages.en);
                        } else {
                          con.selectLanguage(2);
                          Provider.of<AppLanguage>(context, listen: false)
                              .changeLanguage(language: Languages.ar);
                        }
                      });
                      context.pop();
                    },
                    child: Container(
                      width: 165.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: ThemeClass.of(context).primaryColor),
                      child: Center(
                        child: Text(
                          Strings.change.tr,
                          style: TextStyleHelper.of(context).h_16.copyWith(
                            color: ThemeClass.of(context).background,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

