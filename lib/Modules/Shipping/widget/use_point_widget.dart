import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';

class UsePointWidget extends StatelessWidget {
  const UsePointWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 382.w,
      height: 190.h,
      decoration: BoxDecoration(
        color: ThemeClass.of(context).background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 40.h, start: 12.w, end: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${Strings.youHave.tr}100 points ${Strings.wantToUsePoint.tr}",
                style: TextStyleHelper.of(context).b_16.copyWith(
                    color: ThemeClass.of(context).secondaryBlackColor,
                    fontWeight: FontWeight.w400)),
            Gap(40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    width: 165.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: ThemeClass.of(context).secondary),
                        borderRadius: BorderRadius.circular(30.r),
                        color: ThemeClass.of(context).secondary
                        // ThemeClass.of(context).background.withValues(0.20)
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
                        Strings.yes.tr,
                        style: TextStyleHelper.of(context).h_16.copyWith(
                              color: ThemeClass.of(context).background,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
