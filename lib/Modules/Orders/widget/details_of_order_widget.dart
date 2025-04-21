import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import "package:go_router/go_router.dart";
import 'package:je_t_aime/core/Language/locales.dart';

import "../../../Models/order_model.dart";
import '../../../Utilities/format_date_helper.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import "../../ShowOrderDetails/show_order_screen.dart";

class DetailsOfOrder extends StatelessWidget {
  final OrderModel orderModel;
  const DetailsOfOrder({
    super.key,
    required this.orderModel,
  });
  String getOrderStatusText(int? orderStatus) {
    switch (orderStatus) {
      case 0:
        return Strings.orderPlaced.tr;
      case 1:
        return Strings.inProgress.tr;
      case 2:
        return Strings.shipping.tr;
      case 3:
        return Strings.delivered.tr;
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    print(orderModel.toString());
    return GestureDetector(
      onTap: () {
        //  context.pushNamed(TrackOrderScreen.routeName,extra:orderModel);
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 8.h),
        child: Container(
          //height: 152.h,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            color: ThemeClass.of(context).background,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: ThemeClass.of(context)
                  .secondaryBlackColor
                  .withAlpha((0.15 * 255).toInt()),
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
            padding: EdgeInsetsDirectional.only(top: 16.h, bottom:16.h),
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
                    orderModel.id.toString() ?? "",
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
                    orderModel.paymentMethod ?? "",
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
                  FormatDateHelper.formatWalletDate
                      .format(orderModel.orderDate ?? DateTime.now()),
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
                  getOrderStatusText(orderModel.orderStatus),
                  style: TextStyleHelper.of(context)
                      .h_16
                      .copyWith(color: ThemeClass.of(context).mainBlack),
                ),
              ]),
              Gap(8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).pushNamed(ShowOrderWidget.routeName,
                          extra: orderModel);
                    },
                    child: Text(
                      Strings.viewDetails.tr,
                      style: TextStyleHelper.of(context).b_16.copyWith(
                          decoration: TextDecoration.underline,
                          color: ThemeClass.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
