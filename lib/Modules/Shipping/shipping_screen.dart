import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import "package:je_t_aime/Models/shipping_model.dart";
import 'package:je_t_aime/Modules/Payment/payment_screen.dart';
import 'package:je_t_aime/Modules/Shipping/shipping_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import "../../Models/cart_item_model.dart";
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import '../../Utilities/validate.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_home_details_text_widget.dart';
import '../../Widgets/custom_side_text_widget.dart';
import '../../Widgets/custom_textfield_widget.dart';
import '../../Widgets/loading_screen.dart';
import '../../generated/assets.dart';

class ShippingScreen extends StatefulWidget {
  static const routeName = "ShippingScreen";
  final double subtotal;
  final List<CartModel> products;

  const ShippingScreen({
    super.key, required this.subtotal, required this.products,
  });

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
      //   backgroundColor: Colors.yellow,
      appBar: PreferredSize(
        preferredSize: Size(0, 80.h),
        // padding: const EdgeInsets.all(8.0),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.shippingDetails.tr,
          icon: "",
        ),
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
              padding: EdgeInsetsDirectional.only(start: 23.w, end: 23.w),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSideTextWidget(text: Strings.name.tr),
                  Gap(10.h),
                  CustomTextFieldWidget(
                    hint: Strings.enterYourName.tr,
                    hintStyle: TextStyle(
                        color: ThemeClass.of(context)
                            .secondaryBlackColor
                            .withAlpha((0.6* 255).toInt())),
                    prefixIcon: SvgPicture.asset(Assets.imagesProfileIcon),
                    isDense: true,
                    insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                    backGroundColor:
                        ThemeClass.of(context).secondary.withAlpha((1* 255).toInt()),
                    controller: con.nameController,
                    validator: (v) => Validate.validateFullName(v),
                  ),
                  Gap(10.h),
                  CustomSideTextWidget(text: Strings.address.tr),
                  Gap(10.h),
                  CustomTextFieldWidget(
                    hint: Strings.enterYourAddress.tr,
                    hintStyle: TextStyle(
                        color: ThemeClass.of(context)
                            .secondaryBlackColor
                            .withAlpha((0.6* 255).toInt())),
                    prefixIcon: SvgPicture.asset(Assets.imagesLocation),
                    isDense: true,
                    insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                    backGroundColor:
                        ThemeClass.of(context).secondary.withAlpha((1* 255).toInt()),
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
                        color: ThemeClass.of(context)
                            .secondaryBlackColor
                            .withAlpha((0.6* 255).toInt())),
                    prefixIcon: SvgPicture.asset(Assets.imagesPhone),
                    isDense: true,
                    insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                    backGroundColor:
                        ThemeClass.of(context).secondary.withAlpha((1* 255).toInt()),
                    controller: con.phoneController,
                    validator: (v) => Validate.validatePhone(v),
                  ),
                  Gap(100.h),
                  Container(
                    width: 382.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: ThemeClass.of(context).secondary.withAlpha((1* 255).toInt()),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.imagesDiscountShape),
                          Gap(10.w),
                          Text(
                            "115632",
                            style: TextStyleHelper.of(context).b_16.copyWith(
                                color:
                                    ThemeClass.of(context).secondaryBlackColor),
                          ),
                          const Spacer(),
                          CustomButtonWidget.primary(
                              title: Strings.apply.tr,
                              width: 68.w,
                              height: 40.h)
                        ],
                      ),
                    ),
                  ),
                  Gap(16.h),
                  Row(
                    children: [
                      CustomHomeDetailsTextWidget(
                        text: "100 ${Strings.loyaltyPoints.tr}",
                        style: TextStyleHelper.of(context)
                            .h_16
                            .copyWith(color: ThemeClass.of(context).sideText),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          con.usePointsAlert(context);
                        },
                        child: Text(
                          Strings.usePoint.tr,
                          // textAlign: TextAlign.left,
                          style: TextStyleHelper.of(context).h_16.copyWith(
                              color: ThemeClass.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  Gap(16.h),
                  Container(
                    //  height: 154.h,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                    decoration: BoxDecoration(
                      color: ThemeClass.of(context).background,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: ThemeClass.of(context)
                            .secondaryBlackColor
                            .withAlpha((0.15* 255).toInt()),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeClass.of(context)
                                .secondaryBlackColor
                                .withAlpha((0.15* 255).toInt()),
                            blurRadius: 1,
                            spreadRadius: 0.5),
                      ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: 15.h, bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                Strings.subTotal.tr,
                                style: TextStyleHelper.of(context)
                                    .b_16
                                    .copyWith(
                                        color: ThemeClass.of(context)
                                            .secondaryBlackColor),
                              ),
                              const Spacer(),
                              Text(
                                "${widget.subtotal} ${Strings.jod.tr}",
                                style: TextStyleHelper.of(context)
                                    .h_16
                                    .copyWith(
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                            ],
                          ),
                          Gap(16.h),
                          Row(
                            children: [
                              Text(
                                Strings.shippingCost.tr,
                                style: TextStyleHelper.of(context)
                                    .b_16
                                    .copyWith(
                                        color: ThemeClass.of(context)
                                            .secondaryBlackColor),
                              ),
                              const Spacer(),
                              Text(
                                "20 ${Strings.jod.tr}",
                                style: TextStyleHelper.of(context)
                                    .h_16
                                    .copyWith(
                                        color:
                                            ThemeClass.of(context).mainBlack),
                              ),
                            ],
                          ),
                          Gap(8.h),
                          Divider(
                              thickness: 0.5,
                              color: ThemeClass.of(context)
                                  .secondaryBlackColor
                                  .withAlpha((0.6* 255).toInt())),
                          Gap(8.h),
                          Row(children: [
                            Text(
                              Strings.total.tr,
                              style: TextStyleHelper.of(context).b_16.copyWith(
                                  color: ThemeClass.of(context)
                                      .secondaryBlackColor),
                            ),
                            const Spacer(),
                            Text(
                            "${widget.subtotal+(20)} ${Strings.jod.tr} ",
                              style: TextStyleHelper.of(context).b_16.copyWith(
                                    color: ThemeClass.of(context)
                                        .secondaryBlackColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            Gap(2.w),
                            Text(
                              " ${widget.subtotal} ${Strings.jod.tr}",
                              style: TextStyleHelper.of(context).h_16.copyWith(
                                  color: ThemeClass.of(context).mainBlack),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  Gap(20.h),
                  InkWell(
                    onTap: () {
                     if (_formKey.currentState!.validate()) {
                       context.pushNamed(PaymentScreen.routeName,
                           extra:ShippingModel(
                           name: con.nameController.text,
                           phone: con.phoneController.text,
                           address: con.addressController.text,

                     // products: widget.products,
                      ));

                      } else {
                        setState(() {
                          con.autoValidate = true;
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 15.h),
                      child: CustomButtonWidget.primary(
                        title: Strings.continu.tr ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      //  ),
    );
  }
}
