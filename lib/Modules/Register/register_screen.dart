import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Home/home_screen.dart';
import 'package:je_t_aime/Modules/Register/register_controller.dart';
import 'package:je_t_aime/Widgets/custom_side_text_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_textfield_widget.dart';
import '../../generated/assets.dart';
import '../Login/login_screen.dart';
import '../Login/widgets/user_status_row.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "Register";
  const RegisterScreen({super.key});

  @override
  createState() => _RegisterScreenState();
}

class _RegisterScreenState extends StateMVC<RegisterScreen> {
  _RegisterScreenState() : super(RegisterController()) {
    con = RegisterController();
  }
  late RegisterController con;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //  GoogleSignInAccount? user = con.currentUser;
    return Scaffold(
      body: LoadingScreen(
        loading: con.loading,
        child: Form(
          key: _formKey,
          autovalidateMode: con.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Gap(40.h),
                Center(
                  child: Image.asset(
                    Assets.imagesSignUp,
                    width: 170.w,
                    height:125.h,
                  ),
                ),
                Gap(20.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the container
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff33333326).withOpacity(0.15),// Shadow color
                        spreadRadius: 0, // Spread radius
                        // blurRadius:1, // Blur radius for a soft shadow
                        offset: const Offset(0, -1), // Negative offset to place shadow on top
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(15.h),
                        Center(
                          child: Text(
                            Strings.signUp.tr,
                            style: TextStyleHelper.of(context).h_24,
                          ),
                        ),
                        Gap(15.h),
                        CustomSideTextWidget(text: Strings.email.tr),
                        Gap(8.h),
                        CustomTextFieldWidget(
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context)
                                  .secondaryBlackColor
                                  .withOpacity(0.7)),
                          backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
                          hint: Strings.enterEmail.tr,
                          focusedBorderColor:
                              ThemeClass.of(context).primaryColor,
                          prefixIcon: SvgPicture.asset(Assets.imagesEmailIcon),
                         // isDense: true,
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          controller: con.emailController,
                          validator: (v) => Validate.validateEmail(v),
                        ),
                        Gap(10.h),
                        CustomSideTextWidget(text: Strings.password.tr),
                        Gap(8.h),
                        CustomTextFieldWidget(
                          obscure: con.isPassword,
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context)
                                  .secondaryBlackColor
                                  .withOpacity(0.7)),
                          backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
                          hint: Strings.enterPassword.tr,
                          focusedBorderColor:
                              ThemeClass.of(context).primaryColor,

                          prefixIcon: SvgPicture.asset(Assets.imagesLockIcon),
                          suffixIcon: con.isPassword
                              ? SvgPicture.asset(Assets.imagesObsecureIcon)
                              : SvgPicture.asset(Assets.imagesEyeOpen),
                        //  isDense: true,
                          onSuffixTap: () {
                            setState(() {
                              con.isPassword = !con.isPassword;
                            });
                          },
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          controller: con.passwordController,
                          validator: (v) => Validate.validatePassword(v),
                        ),
                        Gap(10.h),
                        CustomSideTextWidget(text: Strings.repeatPassword.tr),
                        Gap(8.h),
                        CustomTextFieldWidget(
                          obscure: con.isConfirmPassword,
                          hint: Strings.enterPassword.tr,
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context)
                                  .secondaryBlackColor
                                  .withOpacity(0.7)),
                          backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
                          prefixIcon: SvgPicture.asset(Assets.imagesLockIcon),
                          suffixIcon: con.isConfirmPassword
                              ? SvgPicture.asset(Assets.imagesObsecureIcon)
                              : SvgPicture.asset(Assets.imagesEyeOpen),
                         isDense: true,
                          onSuffixTap: () {
                            setState(() {
                              con.isConfirmPassword = !con.isConfirmPassword;
                            });
                          },
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          focusedBorderColor:
                              ThemeClass.of(context).primaryColor,
                          controller: con.confirmPasswordController,
                          validator: (v) => Validate.validateConfPassword(
                              confPassword: con.passwordController.text,
                              newPassword: v!),
                        ),
                        Gap(25.h),
                        CustomButtonWidget.primary(
                            title: Strings.joinUs.tr,
                           onTap: () {

                              if (_formKey.currentState?.validate() ?? false) {
                               con.userRegister();
                              } else {
                                setState(() {
                                  con.autoValidate = true;
                                });
                              }
                            }),
                      Gap(10.h),
                        UserStatusRow(
                          text: Strings.haveAccount.tr,
                          nextText: Strings.login.tr,
                          onNextTextTap: () {
                            context.pushNamed(LoginScreen.routeName);
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: ThemeClass.of(context).labelColor,
                                thickness: 1.w,
                              ),
                            ),
                            Gap(8.w),
                            Text(Strings.or.tr,
                                style: TextStyleHelper.of(context)
                                    .b_16
                                    .copyWith(
                                        color:
                                            ThemeClass.of(context).labelColor)),
                            Gap(8.w),
                            Expanded(
                              child: Divider(
                                color: ThemeClass.of(context).labelColor,
                                thickness: 1.w,
                              ),
                            ),
                          ],
                        ),
                       Gap(15.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.imagesAppleIcon),
                            Gap(15.w),
                            SvgPicture.asset(Assets.imagesGoogleIcon),
                          ],
                        ),
                        Gap(10.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
