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

  //
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

  // String getOrderStatusText(int? orderStatus) {
  //   switch (orderStatus) {
  //     case 0:
  //       return Strings.inProgress.tr;
  //     case 1:
  //       return Strings.shipping.tr;
  //     case 2:
  //       return Strings.delivered.tr;
  //     default:
  //       return "";
  //   }
  // }

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
                    padding: EdgeInsetsDirectional.only(top: 5.h, bottom: 10.h),
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
                                        color:
                                            ThemeClass.of(context).mainBlack),
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
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                              const Spacer(),
                              Text(
                                con.orderModel?.paymentMethod ?? "",
                                style: TextStyleHelper.of(context)
                                    .h_16
                                    .copyWith(
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                            ],
                          ),
                          Gap(8.h),
                          Row(children: [
                            Text(
                              Strings.orderDate.tr,
                              style: TextStyleHelper.of(context).b_16.copyWith(
                                  color: ThemeClass.of(context).mainBlack),
                            ),
                            const Spacer(),
                            Text(
                              FormatDateHelper.formatWalletDate.format(
                                  con.orderModel?.orderDate ?? DateTime.now()),
                              style: TextStyleHelper.of(context).h_16.copyWith(
                                  color: ThemeClass.of(context).mainBlack),
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
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                              const Spacer(),
                              Text(
                                "${con.orderModel?.totalPrice} ${Strings.jod.tr}" ??
                                    "",
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
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                              const Spacer(),
                              Text(
                                "${con.orderModel?.totalPrice} ${Strings.jod.tr}" ??
                                    "",
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
                              style: TextStyleHelper.of(context).b_16.copyWith(
                                  color: ThemeClass.of(context).mainBlack),
                            ),
                            const Spacer(),
                            Text(
                              getOrderStatusText(con.orderModel?.orderStatus),
                              style: TextStyleHelper.of(context).h_16.copyWith(
                                  color: ThemeClass.of(context).mainBlack),
                            ),
                          ]),
                        ]),
                  ),
                ),
                Gap(12.h),
                CustomHomeDetailsTextWidget(
                  text: Strings.products.tr,
                  style: TextStyleHelper.of(context).h_20.copyWith(
                      color: ThemeClass.of(context).mainBlack,
                      fontWeight: FontWeight.w600),
                ),
                Gap(16.h),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: ListView.separated(
                      itemBuilder: (context, index) => Container(
                            height: 92.h,
                            width: 382.w,
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 0.w),
                            decoration: BoxDecoration(
                              color: ThemeClass.of(context).background,
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                color: ThemeClass.of(context)
                                    .secondary.withAlpha((0.16* 255).toInt()),

                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 6,
                                 spreadRadius: 1,
                                 offset: const Offset(0,2),
                                  color: ThemeClass.of(context)
                                      .secondary.withAlpha(128),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal:12.w, vertical: 12.h),
                              child: Row(
                                children: [
                                  Container(
                                    width: 72.w,
                                    height: 68.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        color: ThemeClass.of(context)
                                            .containerColor),
                                    child: _buildImageWidget(
                                      con.orderModel!.products?[index].image,
                                    ),
                                  ),
                                  Gap(8.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        con.orderModel!.products?[index]
                                                .title ??
                                            "",
                                        style: TextStyleHelper.of(context)
                                            .b_16
                                            .copyWith(
                                                color: ThemeClass.of(context)
                                                    .mainBlack),
                                      ), // Moves the delete icon to the end of the row
                                      Gap(4.h),
                                      SizedBox(
                                       width: 235.w,
                                        height: 24.h,
                                        child: Row(
                                          children: [
                                            Text(
                                                "${con.orderModel!.products?[index].price} ${Strings.jod.tr}",
                                                style: TextStyleHelper.of(context)
                                                    .h_16
                                                    .copyWith(
                                                      color: ThemeClass.of(context)
                                                          .primaryColor,
                                                    )),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:  EdgeInsetsDirectional.only(top: 4.h),
                                                  child: Icon(Icons.clear,
                                                  color: ThemeClass.of(context).mainBlack,
                                                  size: 15,
                                                  ),
                                                ),
                                                Text(
                                                    "${con.orderModel!.products?[index].count}",
                                                    style: TextStyleHelper.of(context)
                                                        .h_16
                                                        .copyWith(
                                                      color: ThemeClass.of(context)
                                                          .primaryColor,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => Gap(12.h),
                      itemCount: con.orderModel?.products?.length ?? 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const Icon(
        Icons.image,
        size: 50,
        color: Colors.grey,
      );
    }

    // Simple URL validation (you can use a more robust validation if needed)
    if (!imageUrl.startsWith('http') && !imageUrl.startsWith('https')) {
      return const Icon(
        Icons.image,
        size: 50,
        color: Colors.grey,
      );
    }

    return Image.network(
      imageUrl,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image,
          size: 50,
          color: Colors.grey,
        );
      },
    );
  }
}
