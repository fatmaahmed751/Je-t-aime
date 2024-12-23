import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
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
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 24.w,
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Gap(20.h),
                  const Padding(
                    padding:
                        EdgeInsetsDirectional.symmetric(horizontal: 5.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatarWidget()),
                  ),
                  Gap(20.h),
                  Gap(20.h),
                  Center(
                    child: Image.asset(Assets.imagesForgetPassword),
                  ),
                  Gap(18.h),
                  Center(
                    child: Text(
                      Strings.changePassword.tr,
                      style: TextStyleHelper.of(context).h_24,
                    ),
                  ),
                  Gap(15.h),
                  _buildPasswordField(
                    context: context,
                    suffixIcon:con.isPassword? SvgPicture.asset(Assets.imagesObsecureIcon)
                        :SvgPicture.asset(Assets.imagesEyeOpen),
                    title: Strings.oldPassword.tr,
                    hint: Strings.enterOldPassword.tr,
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
                  _buildPasswordField(
                    context: context,
                    suffixIcon:con.newPassword? SvgPicture.asset(Assets.imagesObsecureIcon)
                        :SvgPicture.asset(Assets.imagesEyeOpen),
                    title: Strings.newPasswordBigTitle.tr,
                    hint: Strings.newPasswordInputText.tr,
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
                  Gap(40.h),
              CustomButtonWidget.primary(
                  title: Strings.save.tr,
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                     // con.getNewPassword();
                    } else {
                      setState(() {
                        con.autoValidate = true;
                      });
                    }
                  }),
                ],
              ),
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
          hintStyle:  TextStyle(color: ThemeClass.of(context).secondary),
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
          backGroundColor: ThemeClass.of(context).secondary,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}
