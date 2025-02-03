import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../../../../Utilities/strings.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../Utilities/format_date_helper.dart';

class EarnPoints extends StatelessWidget {
  const EarnPoints({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: ThemeClass.of(context).background,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(Strings.earnPoints.tr,
                  style: TextStyleHelper.of(context)
                      .b_16
                      .copyWith(color: ThemeClass.of(context).mainBlack)),
              const Spacer(),
              Text("111 ${Strings.points.tr}",
                  style: TextStyleHelper.of(context)
                      .h_16
                      .copyWith(color: ThemeClass.of(context).mainBlack)),
            ],
          ),
          Gap(8.h),
          Row(
            children: [
              Text(
                "${Strings.numberOfOrder.tr} #11112",
                style: TextStyleHelper.of(context).b_14.copyWith(
                    color: ThemeClass.of(context).secondaryBlackColor),
              ),
              const Spacer(),
              Text(
                FormatDateHelper.formatWalletDate.format(DateTime.now()),
                style: TextStyleHelper.of(context).b_14.copyWith(
                    color: ThemeClass.of(context).secondaryBlackColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
