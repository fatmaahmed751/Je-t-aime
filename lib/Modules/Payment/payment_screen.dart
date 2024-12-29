import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Modules/Payment/payment_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/loading_screen.dart';
import '../../generated/assets.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(
        title: Strings.paymentMethod.tr,
        icon: "",
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: Form(
    key: _formKey,
    autovalidateMode: con.autoValidate
    ? AutovalidateMode.always
        : AutovalidateMode.disabled,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 30.h, bottom: 30.h,start: 10.w),
              // horizontal: 20.w, vertical: 30.h),
              child: ListView(
                children: [

                  const Spacer(),
                  CustomButtonWidget.primary(
                      title: Strings.payNow.tr,
                      onTap: () {
                        con.onPaymentSuccess(context);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
