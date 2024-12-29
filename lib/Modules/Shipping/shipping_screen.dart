import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Shipping/shipping_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import '../../Utilities/validate.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_side_text_widget.dart';
import '../../Widgets/custom_textfield_widget.dart';
import '../../Widgets/loading_screen.dart';
import '../../generated/assets.dart';
class ShippingScreen extends StatefulWidget {
  static const routeName = "ShippingScreen";
 // final double subtotal;

   ShippingScreen({super.key,});

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends StateMVC<ShippingScreen> {
  _ShippingScreenState() : super(ShippingController()) {
    con = ShippingController();
  }

  late ShippingController con;
  final GlobalKey<FormState> _formKey = GlobalKey();
@override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    con.reset();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget.detailsScreen(
    title: Strings.shippingDetails.tr,
      icon: "",
    ),

    body: LoadingScreen(
        loading: con.loading,
        child: Form(
          key: _formKey,
          autovalidateMode: con.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 23.w),
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSideTextWidget(text: Strings.name.tr),
                        Gap(10.h),
                        CustomTextFieldWidget(
                          hint: Strings.enterYourName.tr,
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.6)),
                          prefixIcon: SvgPicture.asset(Assets.imagesProfileIcon),
                          isDense: true,
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          backGroundColor: ThemeClass.of(context).secondary.withOpacity(1),
                          controller: con.nameController,
                          validator: (v) => Validate.validateNormalString(v),
                        ),
                        Gap(10.h),
                        CustomSideTextWidget(text: Strings.address.tr),
                        Gap(10.h),
                        CustomTextFieldWidget(
                          hint: Strings.enterYourAddress.tr,
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.6)),
                          prefixIcon: SvgPicture.asset(Assets.imagesLocation),
                          isDense: true,
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          backGroundColor: ThemeClass.of(context).secondary.withOpacity(1),
                          controller: con.addressController,
                          validator: (v) => Validate.validateNormalString(v),
                        ),
                        Gap(10.h),
                        CustomSideTextWidget(text: Strings.phone.tr),
                        Gap(10.h),
                        CustomTextFieldWidget(
                          textInputType: TextInputType.phone,
                          hint: Strings.enterYourPhone.tr,
                          hintStyle: TextStyle(
                              color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.6)),
                          prefixIcon: SvgPicture.asset(Assets.imagesPhone),
                          isDense: true,
                          insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                          backGroundColor: ThemeClass.of(context).secondary.withOpacity(1),
                          controller: con.phoneController,
                          validator: (v) => Validate.validatePhone(v),
                        ),







                        Gap(12.h),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23.w),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("",
                                    //Strings.subtotal.tr,
                                    style: TextStyleHelper.of(context).b_16.copyWith(fontWeight: FontWeight.w500,
                                        color: ThemeClass.of(context).labelColor),
                                  ),
                                  // Gap(254.w),
                                  Text(
                                    " ${Strings.egp.tr}",
                                    style: TextStyleHelper.of(context).h_16.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(16.h),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       Strings.shipping.tr,
                              //       style: TextStyleHelper.of(context).b_16.copyWith(fontWeight: FontWeight.w500,
                              //           color: ThemeClass.of(context).gray),
                              //     ),
                              //     // Gap(254.w),
                              //     Text(
                              //       "${con.selectedArea?.shippingFees??'0'} ${Strings.egp.tr}",
                              //       style: TextStyleHelper.of(context).h_16.copyWith(
                              //         fontWeight: FontWeight.w500,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Gap(16.h),
                              // Container(
                              //   width: 382.w,
                              //   height: 1,
                              //   decoration: BoxDecoration(color:ThemeClass.of(context).borderColor),
                              // ),
                              // Gap(16.h),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       Strings.total.tr,
                              //       style: TextStyleHelper.of(context).b_16.copyWith(fontWeight: FontWeight.w500,
                              //           color: ThemeClass.of(context).gray),
                              //     ),
                              //     // Gap(278.w),
                              //     Text(
                              //       "${widget.subtotal+(con.selectedArea?.shippingFees ?? 0)} ${Strings.egp.tr}",
                              //       style: TextStyleHelper.of(context).h_16.copyWith(
                              //         fontWeight: FontWeight.w500,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        Gap(30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 24.h),
                          child: InkWell(
                            onTap: (){
                              if (_formKey.currentState!.validate()) {


                              } else {
                                setState(() {
                                  con.autoValidate = true;
                                });
                              }
                            },
                            child:  CustomButtonWidget.primary(
                              title: Strings.continu.tr??'',
                            ),
                          ),
                        ),
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
