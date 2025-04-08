import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import "package:je_t_aime/Modules/ShowOrderDetails/show_order_controller.dart";
import 'package:je_t_aime/core/Language/locales.dart';
import "package:mvc_pattern/mvc_pattern.dart";

import "../../Models/order_model.dart";
import '../../Utilities/format_date_helper.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import "../../Widgets/custom_app_bar_widget.dart";
import "../../Widgets/custom_details_app_bar_text_widget.dart";
import "../../Widgets/custom_home_details_text_widget.dart";
import "../../Widgets/loading_screen.dart";
import "../Cart/cart_controller.dart";
import "../Notifications/notifications_controller.dart";
import "../Orders/orders_controller.dart";

class ShowOrderWidget extends StatefulWidget {
  static const routeName = "showOrder";
   final OrderModel orderModel;
  const ShowOrderWidget({
    super.key,
    required this.orderModel,
  });

  @override
  createState() => ShowOrderWidgetState();
}

class ShowOrderWidgetState extends StateMVC<ShowOrderWidget> {
  ShowOrderWidgetState() : super(ShowOrderController()) {
    con = ShowOrderController();
  }

  late ShowOrderController con;
  @override
  void initState() {
    con.init(widget.orderModel);
    super.initState();
  }


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
    print(widget.orderModel.toString());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.orderDetails.tr,
          icon: "",
        ),
      ),
      body: SafeArea(
        child: LoadingScreen(
            loading: con.loading,
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
              child: ListView(
                children: [
                  Container(
                    // height: 184.h,
                    //height: 152.h,
                    // padding:
                    //     EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                    decoration: BoxDecoration(
                      color: ThemeClass.of(context).background,
                    //  borderRadius: BorderRadius.circular(30.r),
                    //   border: Border.all(
                    //     color: ThemeClass.of(context)
                    //         .secondaryBlackColor
                    //         .withAlpha((0.15 * 255).toInt()),
                    //   ),
                      // boxShadow: [
                      //   BoxShadow(
                      //       offset: const Offset(0, 0),
                      //       color: ThemeClass.of(context)
                      //           .secondaryBlackColor
                      //           .withAlpha((0.10 * 255).toInt()),
                      //       blurRadius: 3,
                      //       spreadRadius: 0.3),
                      // ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: 5.h, bottom: 10.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(Strings.orderNumber.tr,
                                    style: TextStyleHelper.of(context)
                                        .b_16
                                        .copyWith(
                                            color: ThemeClass.of(context)
                                                .mainBlack)),
                                const Spacer(),
                                Text(
                                  con.orderModel?.id.toString() ?? "",
                                  style: TextStyleHelper.of(context)
                                      .h_16
                                      .copyWith(
                                          color: ThemeClass.of(context)
                                              .mainBlack),
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
                                      .copyWith(
                                          color: ThemeClass.of(context)
                                              .mainBlack),
                                ),
                                const Spacer(),
                                Text(
                                  con.orderModel?.paymentMethod ?? "",
                                  style: TextStyleHelper.of(context)
                                      .h_16
                                      .copyWith(
                                          color: ThemeClass.of(context)
                                              .mainBlack),
                                ),
                              ],
                            ),
                            Gap(8.h),
                            Row(children: [
                              Text(
                                Strings.orderDate.tr,
                                style: TextStyleHelper.of(context)
                                    .b_16
                                    .copyWith(
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                              const Spacer(),
                              Text(
                                FormatDateHelper.formatWalletDate.format(
                                    con.orderModel?.orderDate ??
                                        DateTime.now()),
                                style: TextStyleHelper.of(context)
                                    .h_16
                                    .copyWith(
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                            ]),
                            Gap(8.h),
                            Row(
                              children: [
                                Text(
                                  Strings.totalPrice.tr,
                                  style: TextStyleHelper.of(context)
                                      .b_16
                                      .copyWith(
                                          color: ThemeClass.of(context)
                                              .mainBlack),
                                ),
                                const Spacer(),
                                Text(
                                  "${con.orderModel?.totalPrice} ${Strings.jod.tr}" ?? "",
                                  style: TextStyleHelper.of(context)
                                      .h_14
                                      .copyWith(
                                          color: ThemeClass.of(context)
                                              .primaryColor),
                                ),
                              ],
                            ),
                            Gap(8.h),
                            Row(
                              children: [
                                Text(
                                  Strings.shippingCost.tr,
                                  style: TextStyleHelper.of(context)
                                      .b_16
                                      .copyWith(
                                          color: ThemeClass.of(context)
                                              .mainBlack),
                                ),
                                const Spacer(),
                                Text(
                                  "${con.orderModel?.totalPrice} ${Strings.jod.tr}"?? "",
                                  style: TextStyleHelper.of(context)
                                      .h_14
                                      .copyWith(
                                    fontWeight: FontWeight.w500,
                                          color: ThemeClass.of(context)
                                              .primaryColor),
                                ),
                              ],
                            ),
                            Gap(8.h),
                            Row(children: [
                              Text(
                                Strings.orderState.tr,
                                style: TextStyleHelper.of(context)
                                    .b_16
                                    .copyWith(
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                              const Spacer(),
                              Text(
                                getOrderStatusText(
                                    con.orderModel?.orderStatus),
                                style: TextStyleHelper.of(context)
                                    .h_16
                                    .copyWith(
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                            ]
                            ),
                          ]
                      ),
                    ),
                  ),
                  Gap(12.h),
                  CustomHomeDetailsTextWidget(
                    text: Strings.products.tr,
                    style: TextStyleHelper.of(context).h_20.copyWith(
                        color: ThemeClass.of(context).mainBlack,
                        fontWeight: FontWeight.w600),
                  ),

                ],
              ),
            )),
      ),
    );
  }
}
