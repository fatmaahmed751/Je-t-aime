import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Utilities/validate.dart';
import '../../../Widgets/custom_home_details_text_widget.dart';
import '../../../Widgets/custom_textfield_widget.dart';

class FilterBottomSheetWidget extends StatefulWidget {
final Widget? sideTextWidget;
final Widget? checkBoxWidget;
final bool autoValidate;
final Function()?onButtonAccept,onButtonReject;
final TextEditingController startController;
final TextEditingController endController;
  const FilterBottomSheetWidget({super.key, this.checkBoxWidget, required this.autoValidate, required this.startController, required this.endController, this.onButtonAccept, this.onButtonReject, this.sideTextWidget});

  @override
  State<FilterBottomSheetWidget> createState() => _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  double _sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: 22.w,
            vertical: 16.h),
        child:Form(
       key: _formKey ,
        autovalidateMode: widget.autoValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.sideTextWidget??const SizedBox.shrink(),

                Gap(10.h),
               widget.checkBoxWidget??const SizedBox.shrink(),
                Gap(10.h),
                CustomHomeDetailsTextWidget(
                  text:Strings.price.tr,
                  style:TextStyleHelper.of(context).b_20.copyWith(
                      color: ThemeClass.of(context).mainBlack,
                      fontWeight: FontWeight.w500),
                ),
                Gap(12.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWidget(
                        width: 165.w,
                        height: 48.h,
                        hint: Strings.from.tr,
                        hintStyle: TextStyle(
                            color: ThemeClass.of(context)
                                .secondaryBlackColor
                                .withOpacity(0.6)),
                        //isDense: true,
                        insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                        backGroundColor:
                        ThemeClass.of(context).secondary.withOpacity(1),
                        controller: widget.startController,
                        //  validator: (v) => Validate.validateNormalFilterNumber(v),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        ":",
                        style: TextStyleHelper.of(context)
                            .h_18
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: CustomTextFieldWidget(
                        width: 165.w,
                        height: 48.h,
                        hint: Strings.to.tr,
                        // isDense: true,
                        hintStyle: TextStyle(
                            color: ThemeClass.of(context)
                                .secondaryBlackColor
                                .withOpacity(0.6)),
                        insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                        backGroundColor:
                        ThemeClass.of(context).secondary.withOpacity(1),
                        controller: widget.endController,
                        validator: (v) => Validate.validateFilterNumber(v,widget.startController.text),
                      ),
                    ),
                  ],
                ),
                Gap(15.h),
                CustomHomeDetailsTextWidget(
                  text:Strings.rateFilter.tr,
                  style:TextStyleHelper.of(context).b_20.copyWith(
                      color: ThemeClass.of(context).mainBlack,
                      fontWeight: FontWeight.w500),
                ),
                Gap(10.h),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:  RoundSliderThumbShape(enabledThumbRadius:9.r), // تصغير الكرة
                        trackHeight: 8.h,
                        activeTrackColor:ThemeClass.of(context).primaryColor,
                        inactiveTrackColor: ThemeClass.of(context).secondary.withOpacity(1),
                        thumbColor:ThemeClass.of(context).primaryColor,
                        overlayShape: const RoundSliderOverlayShape(overlayRadius:10), // حجم الظل حول الكرة عند السحب
                      ),
                      child: Slider(
                        value: _sliderValue,
                        min:0.0,
                        max: 5.0,
                        onChangeStart:(double startValue) {
                          print('Started change at $startValue');
                        },
                        activeColor:ThemeClass.of(context).primaryColor,
                        inactiveColor:ThemeClass.of(context).secondary.withOpacity(1),
                        label: _sliderValue.toStringAsFixed(1),
                        onChanged: (double value) {
                          setState(() {
                            _sliderValue = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal:6.w),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${_sliderValue.toInt()}",style: TextStyleHelper.of(context).
                          b_16.copyWith(
                            color: ThemeClass.of(context).mainBlack
                          )),
                          const Spacer(),
                          Text("5",style:
                              TextStyleHelper.of(context).
                              b_16.copyWith(
                                  color: ThemeClass.of(context).mainBlack
                              ) )
                        ],
                      ),
                    )
                  ],
                ),
                Gap(15.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onButtonReject,
                      child: Container(
                        width: 165.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeClass.of(context).secondary
                            ),
                            borderRadius: BorderRadius.circular(30.r),
                            color:ThemeClass.of(context).secondary.withOpacity(1),
                          // ThemeClass.of(context).background.withOpacity(0.20)
                        ),
                        child: Center(child: Text(Strings.cancel.tr,
                          style: TextStyleHelper.of(context).h_16.copyWith(
                              color: ThemeClass.of(context).secondaryBlackColor
                          ),),
                        ),
                      ),
                    ),
                    Gap(16.w),
                    GestureDetector(
                      onTap: widget.onButtonAccept,
                      child: Container(
                        width: 165.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color:ThemeClass.of(context).primaryColor
                          // ThemeClass.of(context).background.withOpacity(0.20)
                        ),
                        //  backgroundColor: ThemeClass.of(context).primaryColor,
                        child: Center(child: Text(Strings.apply.tr,
                          style: TextStyleHelper.of(context).h_16.copyWith(
                            color: ThemeClass.of(context).background,
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}