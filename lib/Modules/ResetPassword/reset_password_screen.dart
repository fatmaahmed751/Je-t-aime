import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Widgets/custom_side_text_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_textfield_widget.dart';
import '../../../Widgets/loading_screen.dart';
import '../../generated/assets.dart';
import 'reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = "ResetPassword";
  const ResetPasswordScreen({
    Key? key,
    //required this.email,
    // required this.code
  }) : super(key: key);
//final String email;
//final String code;
  @override
  createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends StateMVC<ResetPasswordScreen> {
  _ResetPasswordScreenState() : super(ResetPasswordController()) {
    con = ResetPasswordController();
  }
  late ResetPasswordController con;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //con.email =  widget.email;
//con.pinController.text = widget.code;
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
            padding:
                EdgeInsetsDirectional.symmetric(horizontal: 23.w, vertical: 30),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Gap(8.h),
                Image.asset(Assets.imagesNewPassword),
                Gap(40.h),
                Text(
                  Strings.newPasswordBigTitle.tr,
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.of(context).h_24,
                ),
                Gap(20.h),
                CustomSideTextWidget(
                  text: Strings.newPasswordBigTitle.tr,
                ),
                Gap(15.h),
                CustomTextFieldWidget(
                  focusedBorderColor: ThemeClass.of(context).primaryColor,
                  hint: Strings.enterPassword.tr,
                  backGroundColor: ThemeClass.of(context).secondary,
                  hintStyle:
                      TextStyle(color: ThemeClass.of(context).labelColor),
                  prefixIcon: SvgPicture.asset(Assets.imagesLockIcon),
                  suffixIcon: con.isPassword
                      ? SvgPicture.asset(Assets.imagesObsecureIcon)
                      : SvgPicture.asset(Assets.imagesEmailIcon),
                  isDense: true,
                  onSuffixTap: () {
                    setState(() {
                      con.isPassword = !con.isPassword;
                    });
                  },
                  insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                  controller: con.newPasswordController,
                  validator: (v) => Validate.validatePassword(v),
                ),
                Gap(15.h),
                CustomSideTextWidget(text: Strings.repeatPassword.tr),
                Gap(15.h),
                CustomTextFieldWidget(
                  focusedBorderColor: ThemeClass.of(context).primaryColor,
                  hint: Strings.enterPassword.tr,
                  hintStyle:
                      TextStyle(color: ThemeClass.of(context).labelColor),
                  prefixIcon: SvgPicture.asset(Assets.imagesLockIcon),
                  suffixIcon: con.repeatPassword
                      ? SvgPicture.asset(Assets.imagesObsecureIcon)
                      : SvgPicture.asset(Assets.imagesEmailIcon),
                  isDense: true,
                  onSuffixTap: () {
                    setState(() {
                      con.repeatPassword = !con.repeatPassword;
                    });
                  },
                  insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                  backGroundColor: ThemeClass.of(context).secondary,
                  controller: con.confirmNewPasswordController,
                  validator: (v) => Validate.validateConfPassword(
                      newPassword: v!,
                      confPassword: con.confirmNewPasswordController.text),
                ),
                Gap(20.h),
                Gap(20.h),
                CustomButtonWidget.primary(
                    title: Strings.login.tr,
                    onTap: () {

                      // if (formKey.currentState?.validate() ?? false) {
                      //   // con.getNewPassword();
                      // } else {
                      //   setState(() {
                      //     con.autoValidate = true;
                      //   });
                      // }
                    }),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
