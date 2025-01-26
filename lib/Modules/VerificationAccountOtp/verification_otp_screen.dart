import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Widgets/timer_widget.dart';
import '../../generated/assets.dart';
import 'verification_otp_controller.dart';

class VerificationOtpScreen extends StatefulWidget {
  static const routeName = "otpScreen";
  final int id;

  const VerificationOtpScreen({Key? key, required this.id}) : super(key: key);

  @override
  createState() => _VerificationOtpScreenState();
}

class _VerificationOtpScreenState extends StateMVC<VerificationOtpScreen> {
  _VerificationOtpScreenState() : super(VerificationOtpController()) {
    con = VerificationOtpController();
  }
  late VerificationOtpController con;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con.setUserId(widget.id);
    }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Color focusedBorderColor = ThemeClass.of(context).secondary;
    //Color fillColor = ThemeClass.of(context).secondary;
    Color borderColor = ThemeClass.of(context).secondary;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: ThemeClass.of(context).mainBlack,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
        body: LoadingScreen(
      loading: con.loading,
      child: Form(
        key: formKey,
        autovalidateMode: con.autoValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        child: SafeArea(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(50.h),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 23.w),
                child: Image.asset(Assets.imagesOtpImage),
              ),
              Gap(60.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the container
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff33333326)
                          .withOpacity(0.15), // Shadow color
                      spreadRadius: 0, // Spread radius
                      // blurRadius:1, // Blur radius for a soft shadow
                      offset: const Offset(
                          0, -1), // Negative offset to place shadow on top
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 23.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(50.h),
                      Text(Strings.verificationCode.tr,
                          textAlign: TextAlign.center,
                          style: TextStyleHelper.of(context).h_24),
                      Gap(20.h),
                      SizedBox(
                        width: 382.w,
                        height: 48.h,
                        child: Text(Strings.verificationAccountCode.tr,
                            textAlign: TextAlign.start,
                            style: TextStyleHelper.of(context).b_16.copyWith(
                                color: ThemeClass.of(context)
                                    .secondaryBlackColor
                                    .withOpacity(0.6))),
                      ),
                      Gap(20.h),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          smsRetriever: con.smsRetriever,
                          controller: con.pinController,
                          focusNode: con.focusNode,
                          defaultPinTheme: PinTheme(
                            width: 53.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: ThemeClass.of(context).secondary,
                              borderRadius: BorderRadius.circular(30.r),
                              // border: Border.all(color: ),
                            ),
                            textStyle: TextStyleHelper.of(context)
                                .b_16
                                .copyWith(
                                    color: ThemeClass.of(context)
                                        .secondaryBlackColor),
                          ),
                          separatorBuilder: (index) => const SizedBox(width: 8),
                          validator: (value) {
                            return value == con.pinController.text
                                ? null
                                : 'Pin is incorrect';
                          },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');
                            con.verifyCode(value, con.pinController.text);
                          },
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                color: ThemeClass.of(context).primaryColor,
                              ),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        ),
                      ),
                      Gap(20.h),
                      CustomButtonWidget.primary(
                          radius: 30.r,
                          height: 54.h,
                          title: Strings.continu.tr,
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              con.verifyCodeToVerifyAccount();
                            } else {
                              setState(() {
                                con.autoValidate = true;
                              });
                            }
                          }),
                      Gap(30.h),
                      OtpResendTimer(
                        initialSeconds: 78,
                        onResend: () {
                          con.resendVerifyAccountCode();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsRetrieverApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final signature = await smartAuth.getAppSignature();
    debugPrint('App Signature: $signature');
    final res = await smartAuth.getSmsWithRetrieverApi();
    if (res.hasData && res.requireData.code != null) {
      return res.requireData.code;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
