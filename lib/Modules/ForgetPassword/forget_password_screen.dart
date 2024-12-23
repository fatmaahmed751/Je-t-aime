import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/OTP/verification_otp_screen.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_textfield_widget.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Widgets/circle_avatar_widget.dart';
import '../../Widgets/custom_side_text_widget.dart';
import '../../generated/assets.dart';
import 'forget_password_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = "forgetPassword";
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends StateMVC<ForgetPasswordScreen> {
  _ForgetPasswordScreenState() : super(ForgetPasswordController()) {
    con = ForgetPasswordController();
  }
  late ForgetPasswordController con;
   final GlobalKey<FormState> formKey= GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingScreen(
          loading: con.loading,
          child: Form(
            key: formKey,
            autovalidateMode: con.autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w,vertical: 30.h),
                child: ListView(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatarWidget()),
                    Gap(90.h),
                    Image.asset(Assets.imagesForgetPassword),
                    Gap(60.h),
                    Text(Strings.forgetPasswordBigTitle.tr,
                      textAlign: TextAlign.center,
                      style:  TextStyleHelper.of(context).h_24,),
                    Gap(10.h),
                    SizedBox(
                      width: 382.w,
                      height: 48.h,
                      child: Text(Strings.forgetPasswordDes.tr,
                        textAlign: TextAlign.start,
                        style:  TextStyleHelper.of(context).b_16.copyWith(
                            color:ThemeClass.of(context).secondary
                        ),),
                    ),

                    Gap(15.h),
                    CustomSideTextWidget(text:Strings.email.tr),
                    Gap(15.h),
                    CustomTextFieldWidget(
                      focusedBorderColor: ThemeClass.of(context).primaryColor,
                      hint:Strings.enterEmail.tr,
                      hintStyle:
                      TextStyle(color: ThemeClass.of(context).secondary),
                      prefixIcon: SvgPicture.asset(Assets.imagesEmailIcon),
                      isDense: true,
                      insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                      backGroundColor: ThemeClass.of(context).secondary,
                      controller: con.emailController,
                      validator: (v) => Validate.validateEmail(v),
                    ),
                    Gap(25.h),
                    CustomButtonWidget.primary(
                      radius: 30.r,
                        height: 54.h,
                        title: Strings.sendCode.tr,
                        onTap: () {
                          context.pushNamed(VerificationOtpScreen.routeName);

                          // if (formKey.currentState?.validate() ?? false) {
                          //  // con.onForgetPassword();
                          // } else {
                          //   setState(() {
                          //     con.autoValidate = true;
                          //   });
                          //   context.pushNamed(VerificationOtpScreen.routeName);
                          // }
                        }
                        ),
                    Gap(20.h),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
