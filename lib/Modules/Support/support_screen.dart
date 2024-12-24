import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Modules/Support/support_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_side_text_widget.dart';
import '../../Widgets/custom_textfield_widget.dart';
import '../../generated/assets.dart';

class SupportScreen extends StatefulWidget {
  static const routeName = "Support";
  const SupportScreen({super.key});

  @override
  createState() => _SupportScreenState();
}

class _SupportScreenState extends StateMVC<SupportScreen> {
  _SupportScreenState() : super(SupportController()) {
    con = SupportController();
  }

  late SupportController con;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(
        title: Strings.support.tr,
        icon: "",),
        body: LoadingScreen(
            loading: con.loading,
            child: Form(
              key: _formKey,
              autovalidateMode: con.autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 23.w,),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        CustomSideTextWidget(text: Strings.email.tr),
                        Gap(10.h),
                        CustomTextFieldWidget(
                          hint: Strings.enterEmail.tr,
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context).labelColor),
                          prefixIcon: SvgPicture.asset(Assets.imagesEmailIcon),
                          isDense: true,
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          backGroundColor: ThemeClass.of(context).secondary,
                          controller: con.emailController,
                          validator: (v) => Validate.validateEmail(v),
                        ),
                        Gap(10.h),
                        CustomSideTextWidget(text: Strings.name.tr),
                        Gap(10.h),
                        CustomTextFieldWidget(
                          hint: Strings.enterYourName.tr,
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context).labelColor),
                          prefixIcon: SvgPicture.asset(Assets.imagesProfileIcon),
                          isDense: true,
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          backGroundColor: ThemeClass.of(context).secondary,
                          controller: con.nameController,
                          validator: (v) => Validate.validateNormalString(v),
                        ),
                        Gap(10.h),
                        CustomSideTextWidget(text: Strings.phone.tr),
                        Gap(10.h),
                        CustomTextFieldWidget(
                          textInputType: TextInputType.phone,
                          hint: Strings.enterYourPhone.tr,
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context).labelColor),
                          prefixIcon: SvgPicture.asset(Assets.imagesPhone),
                          isDense: true,
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          backGroundColor: ThemeClass.of(context).secondary,
                          controller: con.phoneController,
                          validator: (v) => Validate.validatePhone(v),
                        ),
                        Gap(10.h),
                        CustomSideTextWidget(text: Strings.writeYourProblem.tr),
                          Gap(10.h),
                          Container(
                            height: 129.h,
                            width: 382.w,
                            decoration: BoxDecoration(
                              color: ThemeClass.of(context).secondary,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: CustomTextFieldWidget(
                              controller: con.problemController,
                              textInputType: TextInputType.text,
                              hint: Strings.descProblem.tr,
                              borderColor: Colors.transparent,
                              hintStyle: TextStyle(
                                  color: ThemeClass.of(context).labelColor),
                              focusedBorderColor: Colors.transparent,
                              disableBorder: false,
                              validator: (v) =>
                                  Validate.validateNormalString(v),
                            ),
                          ),
                      Gap(60.h),

                          CustomButtonWidget.primary(
                              title: Strings.send.tr,
                              onTap: () {
                              //  con.submitProblemSuccessfully();
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
