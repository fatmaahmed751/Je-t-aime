import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/PersonalData/personal_data_controller.dart';
import 'package:je_t_aime/Widgets/custom_side_text_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/shared_preferences.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_textfield_widget.dart';
import '../../generated/assets.dart';
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
      appBar: CustomAppBarWidget.mainScreen(
          title: Strings.personalData.tr,
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
                  horizontal: 8.w,),
              child:isLogin?
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 20.w),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                 // width: 382.w,
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(25.h),
                      CustomSideTextWidget(text: Strings.email.tr),
                      Gap(10.h),
                      CustomTextFieldWidget(
                        hint: Strings.enterEmail.tr,
                        hintStyle: TextStyle(
                            color: ThemeClass.of(context).secondary),
                        prefixIcon: SvgPicture.asset(Assets.imagesPersonal),
                        isDense: true,
                        insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                        backGroundColor: ThemeClass.of(context).secondary,
                        controller: con.nameController,
                        validator: (v) => Validate.validateFullName(v),
                      ),
                      Gap(10.h),
                      CustomSideTextWidget(text: Strings.name.tr),
                      Gap(10.h),
                      CustomTextFieldWidget(
                        hint: Strings.enterYourName.tr,
                        hintStyle: TextStyle(
                            color: ThemeClass.of(context).secondary),
                        prefixIcon: SvgPicture.asset(Assets.imagesProfileIcon),
                        isDense: true,
                        insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                        backGroundColor: ThemeClass.of(context).secondary,
                        controller: con.addressController,
                        validator: (v) => Validate.validateNormalAddress(v),
                      ),
                      Gap(10.h),
                      CustomSideTextWidget(text: Strings.phone.tr),
                      Gap(10.h),
                      CustomTextFieldWidget(
                        textInputType: TextInputType.phone,
                        hint: Strings.enterYourPhone.tr,
                        hintStyle: TextStyle(
                            color: ThemeClass.of(context).secondary),
                        prefixIcon: SvgPicture.asset(Assets.imagesPhone),
                        isDense: true,
                        insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                        backGroundColor: ThemeClass.of(context).secondary,
                        controller: con.phoneController,
                        validator: (v) => Validate.validatePhone(v),
                      ),
                      CustomSideTextWidget(text: Strings.address.tr),
                      Gap(10.h),
                      CustomTextFieldWidget(
                        textInputType: TextInputType.phone,
                        hint: Strings.enterYourAddress.tr,
                        hintStyle: TextStyle(
                            color: ThemeClass.of(context).secondary),
                        prefixIcon: SvgPicture.asset(Assets.imagesLocation),
                        isDense: true,
                        insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                        backGroundColor: ThemeClass.of(context).secondary,
                        controller: con.phoneController,
                        validator: (v) => Validate.validatePhone(v),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //context.pushNamed(ForgetPasswordScreen.routeName);
                            },
                            child: Text(
                              Strings.changePassword.tr,
                              textAlign: TextAlign.left,
                              style: TextStyleHelper.of(context).b_16.copyWith(
                                  color: ThemeClass.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    //  Gap(400.h),
                     // const Spacer(),
                      CustomButtonWidget.primary(
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

                    ],
                  ),
                ),
              ):
              ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 20.0.w, vertical: 100.h),
                      child: SizedBox(
                        width: 325.w,
                        height: 510.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Assets.imagesPersonalData),
                            Gap(10.h),
                            Text(
                              Strings.noPersonalData.tr,
                              textAlign: TextAlign.center,
                              style: TextStyleHelper.of(context).h_24,
                            ),
                            Gap(10.h),
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
                            Gap(25.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButtonWidget.primary(
                      title: Strings.joinUs.tr,
                      onTap: () {
                        GoRouter.of(context).pushNamed(LoginScreen.routeName);
                      }
                  ),
                ],
              )

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
