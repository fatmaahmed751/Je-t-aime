import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Widgets/custom_side_text_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/strings.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../../Utilities/validate.dart';
import '../../../../Widgets/custom_button_widget.dart';
import '../../../../Widgets/custom_textfield_widget.dart';
import '../../../../Widgets/loading_screen.dart';
import '../../Widgets/circle_avatar_widget.dart';
import '../../generated/assets.dart';
import '../ForgetPassword/forget_password_screen.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = "changePassword";
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends StateMVC<ChangePasswordScreen> {
  _ChangePasswordScreenState() : super(ChangePasswordController()) {
    con = ChangePasswordController();
  }
  late ChangePasswordController con;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


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
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Gap(20.h),
                 Padding(
                  padding:
                      EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                  child: const Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatarWidget()),
                ),
                Center(
                  child: Image.asset(Assets.imagesNewPassword,
                //  width: ,
                  height: 212.h,),
                ),
                Gap(18.h),
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
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 24.w),
                    child: Column(
                      children: [
                        Gap(20.h),
                        Center(
                          child: Text(
                            Strings.changePasswordTitle.tr,
                            style: TextStyleHelper.of(context).h_24,
                          ),
                        ),
                        Gap(15.h),
                        CustomSideTextWidget(text: Strings.oldPassword.tr),
                        _buildPasswordField(
                          context: context,
                          suffixIcon:con.isPassword? SvgPicture.asset(Assets.imagesObsecureIcon)
                              :SvgPicture.asset(Assets.imagesEyeOpen),
                          title: Strings.oldPassword.tr,
                          hint: Strings.enterPassword.tr,
                          controller: con.oldPasswordController,
                          validator: Validate.validatePassword,
                          isPassword: con.isPassword,
                          onSuffixTap: () {
                            setState(() {
                              con.isPassword = !con.isPassword;
                            });
                          },
                        ),
                        Gap(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(ForgetPasswordScreen.routeName);
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
                        Gap(10.h),
                        _buildPasswordField(
                          context: context,
                          suffixIcon:con.newPassword? SvgPicture.asset(Assets.imagesObsecureIcon)
                              :SvgPicture.asset(Assets.imagesEyeOpen),
                          title: Strings.newPasswordBigTitle.tr,
                          hint: Strings.enterPassword.tr,
                          controller: con.newPasswordController,
                          validator: Validate.validatePassword,
                          isPassword: con.newPassword,
                          onSuffixTap: () {
                            setState(() {
                              con.newPassword = !con.newPassword;
                            });
                          },
                        ),
                        Gap(10.h),
                        _buildPasswordField(
                          context: context,
                          suffixIcon:con.repeatPassword? SvgPicture.asset(Assets.imagesObsecureIcon)
                              :SvgPicture.asset(Assets.imagesEyeOpen),
                          title: Strings.repeatPassword.tr,
                          hint: Strings.enterPassword.tr,
                          controller: con.confirmNewPasswordController,
                          validator: (v) => Validate.validateConfPassword(
                            confPassword: con.confirmNewPasswordController.text,
                            newPassword: v!,
                          ),

                          isPassword: con.repeatPassword,
                          onSuffixTap: () {
                            setState(() {
                              con.repeatPassword = !con.repeatPassword;
                            });
                          },
                        ),
                        Gap(60.h),
                        CustomButtonWidget.primary(
                        title: Strings.changePasswordTitle.tr,
                        onTap: () {
                          con.displayBottomSheet(context);

                          // if (formKey.currentState?.validate() ?? false) {
                          //  con.displayBottomSheet(context);
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required String title,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required bool isPassword,
    required Widget suffixIcon,
    required VoidCallback onSuffixTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       CustomSideTextWidget(text: title),
        Gap(10.h),
        CustomTextFieldWidget(
          obscure: isPassword,
          hint: hint,
          hintStyle: TextStyle(
              color: ThemeClass.of(context)
                  .secondaryBlackColor
                  .withOpacity(0.7)),
          backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
          prefixIcon: SvgPicture.asset(Assets.imagesLockIcon),
          isDense: true,
          suffixIcon:suffixIcon,
          onSuffixTap:onSuffixTap,
          //     () {
          //   setState(() {
          //  isPassword = !isPassword;
          //   });
          // },
          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}
