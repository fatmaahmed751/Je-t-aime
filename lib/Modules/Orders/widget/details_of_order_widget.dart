import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../../../Utilities/format_date_helper.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';

class DetailsOfOrder extends StatelessWidget {
  const DetailsOfOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // print(orderModel.toString());
    return GestureDetector(
      onTap: () {
        //  context.pushNamed(TrackOrderScreen.routeName,extra:orderModel);
      },
      child: Container(
        //height: 152.h,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: ThemeClass.of(context).secondaryBlackColor.withAlpha((0.15 * 255).toInt()),
          ),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: ThemeClass.of(context)
                    .secondaryBlackColor
                    .withAlpha((0.10 * 255).toInt()),
                blurRadius: 3,
                spreadRadius: 0.3),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, bottom: 10.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(Strings.orderNumber.tr,
                    style: TextStyleHelper.of(context)
                        .b_16
                        .copyWith(color: ThemeClass.of(context).mainBlack)),
                const Spacer(),
                Text(
                  "#11111",
                  style: TextStyleHelper.of(context)
                      .h_16
                      .copyWith(color: ThemeClass.of(context).mainBlack),
                ),
              ],
            ),
            Gap(8.h),
            Row(
              children: [
                Text(
                  Strings.paymentMethod.tr,
                  style: TextStyleHelper.of(context)
                      .b_16
                      .copyWith(color: ThemeClass.of(context).mainBlack),
                ),
                const Spacer(),
                Text(
                  "Visa",
                  style: TextStyleHelper.of(context)
                      .h_16
                      .copyWith(color: ThemeClass.of(context).mainBlack),
                ),
              ],
            ),
            Gap(8.h),
            Row(children: [
              Text(
                Strings.orderDate.tr,
                style: TextStyleHelper.of(context)
                    .b_16
                    .copyWith(color: ThemeClass.of(context).mainBlack),
              ),
              const Spacer(),
              Text(
                FormatDateHelper.formatWalletDate.format(DateTime.now()),
                style: TextStyleHelper.of(context)
                    .h_16
                    .copyWith(color: ThemeClass.of(context).mainBlack),
              ),
            ]),
            Gap(8.h),
            Row(children: [
              Text(
                Strings.orderState.tr,
                style: TextStyleHelper.of(context)
                    .b_16
                    .copyWith(color: ThemeClass.of(context).mainBlack),
              ),
              const Spacer(),
              Text(
                Strings.delivered.tr,
                style: TextStyleHelper.of(context)
                    .h_16
                    .copyWith(color: ThemeClass.of(context).mainBlack),
              ),
            ]),
            Gap(8.h)
          ]),
        ),
      ),
    );
  }
}
