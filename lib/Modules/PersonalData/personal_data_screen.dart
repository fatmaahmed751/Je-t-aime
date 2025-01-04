import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/PersonalData/personal_data_controller.dart';
import 'package:je_t_aime/Widgets/custom_side_text_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_textfield_widget.dart';
import '../../generated/assets.dart';
import '../ChangePassword/change_password_screen.dart';
import '../Login/login_screen.dart';

class PersonalDataScreen extends StatefulWidget {
  static const routeName = "PersonalData";
  const PersonalDataScreen({super.key});

  @override
  createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends StateMVC<PersonalDataScreen> {
  _PersonalDataScreenState() : super(PersonalDataController()) {
    con = PersonalDataController();
  }
  late PersonalDataController con;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLogin = true;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0,75.h),
        child: CustomAppBarWidget.detailsScreen(
            title: Strings.personalData.tr,
        icon: "",),
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
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 8.w,),
              child:isLogin?
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 20.w),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomSideTextWidget(text: Strings.email.tr),
                    Gap(10.h),
                    CustomTextFieldWidget(
                      height:48.h,
                      hint: Strings.enterEmail.tr,
                      hintStyle: TextStyle(
                          color: ThemeClass.of(context)
                              .secondaryBlackColor
                              .withOpacity(0.6)),
                      prefixIcon: SvgPicture.asset(Assets.imagesEmailIcon),
                    //  isDense: true,
                      insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                      backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
                      controller: con.emailController,
                      validator: (v) => Validate.validateEmail(v),
                    ),
                    Gap(10.h),
                    CustomSideTextWidget(text: Strings.name.tr),
                    Gap(10.h),
                    CustomTextFieldWidget(
                      height:48.h,
                      hint: Strings.enterYourName.tr,
                      hintStyle: TextStyle(
                          color: ThemeClass.of(context)
                              .secondaryBlackColor
                              .withOpacity(0.6)),
                      prefixIcon: SvgPicture.asset(Assets.imagesProfileIcon),
                     // isDense: true,
                      insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                      backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
                      controller: con.nameController,
                      validator: (v) => Validate.validateFullName(v),
                    ),
                    Gap(10.h),
                    CustomSideTextWidget(text: Strings.phone.tr),
                    Gap(10.h),
                    CustomTextFieldWidget(
                      borderRadiusValue: 30.r,
                      height:48.h,
                      textInputType: TextInputType.phone,
                      hint: Strings.enterYourPhone.tr,
                      hintStyle: TextStyle(
                          color: ThemeClass.of(context)
                              .secondaryBlackColor
                              .withOpacity(0.6)),
                      prefixIcon: SvgPicture.asset(Assets.imagesPhone),
                      isDense: true,
                      insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                      backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
                      controller: con.phoneController,
                      validator: (v) => Validate.validatePhone(v),
                    ),
                    Gap(10.h),
                    CustomSideTextWidget(text: Strings.address.tr),
                    Gap(10.h),
                    CustomTextFieldWidget(
                      borderRadiusValue: 30.r,
                      focusedBorderColor:ThemeClass.of(context).primaryColor ,
                      height:48.h,
                      hint: Strings.enterYourAddress.tr,
                      prefixIcon: SvgPicture.asset(Assets.imagesLocation),
                      isDense: true,
                      insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                      hintStyle: TextStyle(
                          color: ThemeClass.of(context)
                              .secondaryBlackColor
                              .withOpacity(0.6)),
                      backGroundColor:  ThemeClass.of(context).secondary.withOpacity(1),
                      controller: con.addressController,
                      validator: (v) => Validate.validateNormalAddress(v),
                    ),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                          context.pushNamed(ChangePasswordScreen.routeName);
                          },
                          child: Text(
                            Strings.changePassword.tr,
                            textAlign: TextAlign.left,
                            style: TextStyleHelper.of(context).h_16.copyWith(
                                color: ThemeClass.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  Gap(150.h),
                   // const Spacer(),
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 15.h),
                      child: CustomButtonWidget.primary(
                          title: Strings.update.tr,
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {

                            } else {
                              setState(() {
                                con.autoValidate = true;
                              });
                            }
                          }
                      ),

                    ),
                    Gap(30.h)
                  ],
                ),
              ):
              Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 20.w,end: 20.w),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
               // mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset(Assets.imagesPersonalData,
                 height: 340.h,
                   fit: BoxFit.cover,
                  ),
                  Text(
                    Strings.noPersonalData.tr,
                    textAlign: TextAlign.center,
                    style: TextStyleHelper.of(context).h_24,
                  ),
               Gap(20.h),
                  SizedBox(
                    width: 382.w,
                    height: 90.h,
                    child: Text(
                      Strings.createAccountFirst.tr,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyleHelper.of(context).b_16.copyWith(
                          color: ThemeClass.of(context).labelColor),
                    ),
                  ),
                  Gap(5.h),

                  CustomButtonWidget.primary(
                      width: 153.w,
                      title: Strings.login.tr,
                      onTap: () {
                        GoRouter.of(context).pushNamed(LoginScreen.routeName);
                      }
                  ),
                ],
              ),
            ),

            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmDataSaved extends StatelessWidget {
  const ConfirmDataSaved({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 373.w,
        height: 429.h,
        decoration: BoxDecoration(
            color: ThemeClass.of(context).background,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             // Image.asset(Assets.imagesConfirmData),
              Gap(15.h),
              Text(Strings.confirmSaveData.tr,
                  style: TextStyleHelper.of(context)
                      .h_24
                      .copyWith(decoration: TextDecoration.none))
            ],
          ),
        ),
      ),
    );
  }
}
