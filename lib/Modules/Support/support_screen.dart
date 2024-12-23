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
        // appBar: CustomAppBarWidget.mainDetailsScreen(
        //     screenName: Strings.support.tr,
        // ),
        body: LoadingScreen(
            loading: con.loading,
            child: Form(
              key: _formKey,
              autovalidateMode: con.autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 23.w,),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Gap(20.h),
                            Text(
                              Strings.email.tr,
                              style: TextStyleHelper.of(context).b_16,
                            ),
                            Gap(10.h),
                            CustomTextFieldWidget(
                              hint: Strings.enterEmail.tr,
                              hintStyle: TextStyle(
                                  color: ThemeClass.of(context).labelColor),
                              prefixIcon: SvgPicture.asset(Assets.imagesEmailIc),
                              isDense: true,
                              insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                              backGroundColor: ThemeClass.of(context).inputColor,
                              controller: con.emailController,
                              validator: (v) => Validate.validateEmail(v),
                            ),
                            Gap(10.h),
                            Text(
                              Strings.phone.tr,
                              style: TextStyleHelper.of(context).b_18,
                            ),
                            Gap(10.h),
                            CustomTextFieldWidget(
                              hint: Strings.enterYourPhone.tr,
                              textInputType: TextInputType.phone,
                              hintStyle: TextStyle(
                                  color: ThemeClass.of(context).labelColor),
                              prefixIcon: SvgPicture.asset(Assets.imagesMobile),
                              isDense: true,
                              insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                              backGroundColor: ThemeClass.of(context).inputColor,
                              controller: con.phoneController,
                              validator: (v) => Validate.validatePhone(v),
                            ),
                            Gap(10.h),
                            Text(
                              Strings.yourProblem.tr,
                              style: TextStyleHelper.of(context).b_18,
                            ),
                            Gap(10.h),
                            Container(
                              height: 231.h,
                              width: 382.w,
                              decoration: BoxDecoration(
                                color: ThemeClass.of(context).secondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomTextFieldWidget(
                                controller: con.problemController,
                                textInputType: TextInputType.text,
                                hint: Strings.descProblem.tr,
                                borderColor: Colors.transparent,
                                focusedBorderColor: Colors.transparent,
                                disableBorder: false,
                                validator: (v) =>
                                    Validate.validateNormalString(v),
                              ),
                            ),
                        Gap(250.h),

                            CustomButtonWidget.primary(
                                title: Strings.send.tr,
                                onTap: () {
                                  con.submitProblemSuccessfully();
                                }),
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
