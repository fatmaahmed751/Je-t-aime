import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
      onTap: (){
      //  context.pushNamed(TrackOrderScreen.routeName,extra:orderModel);
      },
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 5.h),
        child: Container(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 15.w, vertical:5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border(
              bottom: BorderSide(
                color: ThemeClass.of(context).primaryColor,
                width: 0.2, // Thickness of the bottom border
              ),
            ),
            boxShadow: [
              // BoxShadow(
              //   color: ThemeClass.of(context)
              //       .primaryColor
              //       .withOpacity(0.1), // Shadow color
              //   blurRadius: 4,
              //   offset: const Offset(0, 0),
              // ),
              // BoxShadow(
              //   color: ThemeClass.of(context)
              //       .primaryColor
              //       .withOpacity(0.1), // Shadow color
              //   blurRadius: 4,
              //   offset: const Offset(-2, -2),
              // ),
              BoxShadow(
                color: ThemeClass.of(context).primaryColor.withOpacity(0.15), // Shadow color
                blurRadius: 10,
                //spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(Strings.orderNumber.tr,
                    style: TextStyleHelper.of(context)
                        .b_16
                        .copyWith(color: const Color(0xff7C7671))),
                const Spacer(),
                Text(
                "",
                  style: TextStyleHelper.of(context)
                      .b_16
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
                    .copyWith(color: const Color(0xff7C7671)),
              ),
              Gap(10.w),
              const Spacer(),
              Text(
                FormatDateHelper.formatWalletDate.format( DateTime.now()),
                style: TextStyleHelper.of(context)
                    .b_16
                    .copyWith(color: ThemeClass.of(context).mainBlack),
              ),
            ]),
            Gap(8.h),
            Row(
              children: [
                Text(
                  Strings.paymentMethod.tr,
                  style: TextStyleHelper.of(context)
                      .b_16
                      .copyWith(color: const Color(0xff7C7671)),
                ),
                const Spacer(),
                Text(
               "",
                  style: TextStyleHelper.of(context)
                      .b_16
                      .copyWith(color: ThemeClass.of(context).mainBlack),
                ),
              ],
            ),
            Gap(8.h),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                " EGP",
                style: TextStyleHelper.of(context)
                    .b_16
                    .copyWith(color: ThemeClass.of(context).primaryColor),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
