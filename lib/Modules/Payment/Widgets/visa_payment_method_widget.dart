import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Utilities/shared_preferences.dart';
import 'package:je_t_aime/Utilities/text_style_helper.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Utilities/strings.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_home_details_text_widget.dart';
import '../../../Widgets/custom_side_text_widget.dart';
import '../../../Widgets/custom_textfield_widget.dart';
import '../../../Widgets/loading_screen.dart';
import '../payment_controller.dart';

class VisaPaymentMethodWidget extends StatefulWidget {
  const VisaPaymentMethodWidget({super.key});

  @override
  createState() => VisaPaymentMethodWidgetState();
}

class VisaPaymentMethodWidgetState extends StateMVC<VisaPaymentMethodWidget> {
  VisaPaymentMethodWidgetState() : super(PaymentController()) {
    con = PaymentController();
  }

  late PaymentController con;
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      loading: con.loading,
      child: Form(
        key: _formKey,
        autovalidateMode: con.autoValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 24.w, vertical: 20.h),
            // horizontal: 20.w, vertical: 30.h),(
            child: Column(
              //physics: const NeverScrollableScrollPhysics(),
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSideTextWidget(
                  text: Strings.cardName.tr,
                ),
                Gap(2.h),
                CustomHomeDetailsTextWidget(
                  text: Strings.writtenOnCard.tr,
                  style: TextStyleHelper.of(context).b_14.copyWith(
                      color: ThemeClass.of(context)
                          .secondaryBlackColor
                          .withOpacity(0.6)),
                ),
                Gap(10.h),
                CustomTextFieldWidget(
                  hint: Strings.writeCardName.tr,
                  hintStyle: TextStyle(
                      color: ThemeClass.of(context)
                          .secondaryBlackColor
                          .withOpacity(0.6)),
                  isDense: true,
                  insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                  backGroundColor:
                      ThemeClass.of(context).secondary.withOpacity(1),
                  controller: con.cardNameController,
                  validator: (v) => Validate.validateNormalString(v),
                ),
                Gap(10.h),
                CustomSideTextWidget(text: Strings.cardNumber.tr),
                Gap(2.h),
                CustomHomeDetailsTextWidget(
                  text: Strings.digitNumber.tr,
                  style: TextStyleHelper.of(context).b_14.copyWith(
                      color: ThemeClass.of(context)
                          .secondaryBlackColor
                          .withOpacity(0.6)),
                ),
                Gap(10.h),
                CustomTextFieldWidget(
                  hint: Strings.writeCardNumber.tr,
                  hintStyle: TextStyle(
                      color: ThemeClass.of(context)
                          .secondaryBlackColor
                          .withOpacity(0.6)),
                  isDense: true,
                  insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                  backGroundColor:
                      ThemeClass.of(context).secondary.withOpacity(1),
                  controller: con.cardNumberController,
                  validator: (v) => Validate.validateNormalString(v),
                ),
                Gap(10.h),
                CustomSideTextWidget(text: Strings.expirationDate.tr),
                Gap(2.h),
                CustomHomeDetailsTextWidget(
                  text: Strings.monthAndYear.tr,
                  style: TextStyleHelper.of(context).b_14.copyWith(
                      color: ThemeClass.of(context)
                          .secondaryBlackColor
                          .withOpacity(0.6)),
                ),
                Gap(10.h),
                CustomTextFieldWidget(
                  hint: Strings.writeExpirationDate.tr,
                  hintStyle: TextStyle(
                      color: ThemeClass.of(context)
                          .secondaryBlackColor
                          .withOpacity(0.6)),
                  isDense: true,
                  insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                  backGroundColor:
                      ThemeClass.of(context).secondary.withOpacity(1),
                  controller: con.expirationDateController,
                  validator: (v) => Validate.validatePhone(v),
                ),
                Gap(10.h),
                CustomSideTextWidget(text: Strings.cvv.tr),
                Gap(2.h),
                CustomHomeDetailsTextWidget(
                  text: Strings.backNumberCard.tr,
                  style: TextStyleHelper.of(context).b_14.copyWith(
                      color: ThemeClass.of(context)
                          .secondaryBlackColor
                          .withOpacity(0.6)),
                ),
                Gap(10.h),
                CustomTextFieldWidget(
                  textInputType: TextInputType.phone,
                  hint: Strings.writeCvvNumber.tr,
                  hintStyle: TextStyle(
                      color: ThemeClass.of(context)
                          .secondaryBlackColor
                          .withOpacity(0.6)),
                  isDense: true,
                  insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                  backGroundColor:
                      ThemeClass.of(context).secondary.withOpacity(1),
                  controller: con.cvvController,
                  validator: (v) => Validate.validatePhone(v),
                ),
               Gap(SharedPref.getCurrentLanguage() =="ar"?40.h:90.h),

                CustomButtonWidget.primary(
                    title: Strings.payNow.tr,
                    onTap: () {
                      con.visaPaymentSuccess(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
