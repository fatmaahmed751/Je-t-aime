import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Modules/Payment/payment_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/loading_screen.dart';
import '../../generated/assets.dart';
import 'Widgets/cash_payment_method_widget.dart';
import 'Widgets/visa_payment_method_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = "PaymentScreen";
  const PaymentScreen({super.key});

  @override
  createState() => PaymentScreenState();
}

class PaymentScreenState extends StateMVC<PaymentScreen> {
  PaymentScreenState() : super(PaymentController()) {
    con = PaymentController();
  }

  late PaymentController con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 80.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.paymentMethod.tr,
          icon: "",
        ),
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                child: togglePaymentsMethodsWidget(),
              ),
              con.isClick
                  ? VisaPaymentMethodWidget()
                  : CashPaymentMethodWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget togglePaymentsMethodsWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                con.isClick = !con.isClick;
              });
            },
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                  vertical: 20.h, horizontal: 16.w),
              width: 170.w,
              height: 56.h,
              decoration: BoxDecoration(
                  color: con.isClick
                      ? ThemeClass.of(context).primaryColor
                      : Colors.transparent,
                  border: Border.all(
                    color: con.isClick
                        ? Colors.transparent
                        : ThemeClass.of(context)
                            .secondaryBlackColor
                            .withAlpha((0.6* 255).toInt()),
                  ),
                  borderRadius: BorderRadius.circular(30.r)),
              clipBehavior: Clip.hardEdge,
              child: SvgPicture.asset(
                Assets.imagesVisalogo,
                color: con.isClick
                    ? ThemeClass.of(context).background
                    : ThemeClass.of(context)
                        .secondaryBlackColor
                        .withAlpha((0.6* 255).toInt()),
              ),
            ),
          ),
          Gap(10.w),
          GestureDetector(
            onTap: () {
              setState(() {
                con.isClick = !con.isClick;
              });
            },
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w, vertical: 13.h),
              width: 170.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: !con.isClick
                    ? ThemeClass.of(context).primaryColor
                    : ThemeClass.of(context).background,
                border: Border.all(
                  color: !con.isClick
                      ? Colors.transparent
                      : ThemeClass.of(context)
                          .secondaryBlackColor
                          .withAlpha((0.6* 255).toInt()),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Text(
                Strings.cash.tr,
                textAlign: TextAlign.center,
                style: TextStyleHelper.of(context).h_16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: !con.isClick
                        ? ThemeClass.of(context).background
                        : ThemeClass.of(context)
                            .secondaryBlackColor
                            .withAlpha((0.6* 255).toInt()),
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ],
      );
}
