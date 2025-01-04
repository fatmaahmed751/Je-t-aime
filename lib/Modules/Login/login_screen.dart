import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Login/widgets/user_status_row.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_side_text_widget.dart';
import '../../Widgets/custom_textfield_widget.dart';
import '../../Widgets/loading_screen.dart';
import '../../generated/assets.dart';
import '../Register/register_screen.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "Login";
  const LoginScreen({super.key});

  @override
  createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
  _LoginScreenState() : super(LoginController()) {
    con = LoginController();
  }
  late LoginController con;
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // GoogleSignInAccount? user = con.currentUser;

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
                Gap(20.h),
                Center(
                  child: Image.asset(Assets.imagesLoginImage,
                    width: 286.w,
                    height: 216.h,),
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
                    padding:EdgeInsetsDirectional.symmetric(horizontal:24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(32.h),
                        Center(
                          child: Text(
                            Strings.login.tr,
                            style: TextStyleHelper.of(context).h_24.copyWith(
                                //fontWeight: FontWeight.w700,
                                fontSize: 25),
                          ),
                        ),
                        Gap(20.h),
                        CustomSideTextWidget(text:Strings.email.tr),
                        Gap(12.h),
                        CustomTextFieldWidget(
                          hint: Strings.enterEmail.tr,
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context)
                                  .secondaryBlackColor
                                  .withOpacity(0.7)),
                          backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
                          prefixIcon: SvgPicture.asset(Assets.imagesEmailIcon),
                         // isDense: true,
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          controller: con.emailController,
                          validator: (v) => Validate.validateEmail(v),
                        ),
                        Gap(10.h),
                        CustomSideTextWidget(text:Strings.password.tr),
                        Gap(12.h),
                        CustomTextFieldWidget(
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context)
                                  .secondaryBlackColor
                                  .withOpacity(0.7)),
                          backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
                          obscure: con.isPassword,
                          focusedBorderColor:ThemeClass.of(context).primaryColor ,
                          hint: Strings.enterPassword.tr,
                          prefixIcon: SvgPicture.asset(Assets.imagesLockIcon),
                          suffixIcon:con.isPassword? SvgPicture.asset(Assets.imagesObsecureIcon)
                          :SvgPicture.asset(Assets.imagesLockIcon),
                          onSuffixTap:(){
                            setState(() {
                             con.isPassword = !con.isPassword;
                            });
                          } ,
                        //  isDense: true,
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          controller: con.passwordController,
                          validator: (v) => Validate.validatePassword(v),
                        ),
                        Gap(8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                //context.pushNamed(ForgetPasswordScreen.routeName);
                              },
                              child: Text(
                                Strings.forgetPassword.tr,
                                textAlign: TextAlign.left,
                                style: TextStyleHelper.of(context).b_16.copyWith(
                                    color: ThemeClass.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                        Gap(12.h),
                        CustomButtonWidget.primary(
                          height: 54.h,
                            radius: 30.r,
                            title: Strings.login.tr,
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                //con.onLogin();
                              } else {
                                setState(() {
                                  con.autoValidate = true;
                                });
                              }
                            }
                            ),
                        Gap(10.h),
                        UserStatusRow(
                          text: Strings.noHavenAccount.tr,
                          nextText: Strings.signUp.tr,
                          onNextTextTap: () {
                          context.pushNamed(RegisterScreen.routeName);
                          },
                        ),
                        Row(
                          children: [
                             Expanded(
                              child: Divider(
                                color:ThemeClass.of(context).labelColor,
                                thickness: 1.w,
                              ),
                            ),
                            Gap(8.w),
                            Text( Strings.or.tr,
                              style: TextStyleHelper.of(context).b_16.copyWith(
                                color:ThemeClass.of(context).labelColor
                              )),
                            Gap(8.w),
                             Expanded(
                              child: Divider(
                                color:ThemeClass.of(context).labelColor,
                                thickness: 1.w,
                              ),
                            ),
                          ],
                        ),
                        Gap(20.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.imagesAppleIcon),
                            Gap(15.w),
                            SvgPicture.asset(Assets.imagesGoogleIcon),
                          ],
                        ),
                        Gap(10.h)
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
