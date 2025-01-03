import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Utilities/theme_helper.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../../../../Utilities/strings.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../generated/assets.dart';

class CustomCheckBoxWidget extends StatefulWidget {
  const CustomCheckBoxWidget({Key? key}) : super(key: key);

  @override
  CustomCheckBoxWidgetState createState() =>
      CustomCheckBoxWidgetState();
}

class CustomCheckBoxWidgetState extends State<CustomCheckBoxWidget> {
 // bool _isChecked = false;
  List<bool> _isCheckedList = [false, false, false, false];
  void handleCheckboxChange(int index) {
    setState(() {
      // Toggle the state of the selected checkbox
      _isCheckedList[index] = !_isCheckedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                handleCheckboxChange(0);
              },
                child: Center(
                  child: SvgPicture.asset(
                  //  _isChecked
                    _isCheckedList[0]
                        ? Assets.imagesCheckBox// Checked SVG
                        : Assets.imagesCheckBox,
                    height: 18.h,
                    width: 18.w,// Unchecked SVG
                  ),
                ),
              ),
           // ),
           Gap(8.w),
          Text(Strings.hairCare.tr,
            style: TextStyleHelper.of(context).b_16.copyWith(
              color: ThemeClass.of(context).mainBlack
            ),
          ),
          ],
        ),
        Gap(13.h),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                handleCheckboxChange(1);
              },
              child: Center(
                child: SvgPicture.asset(
                  _isCheckedList[1]
                      ? Assets.imagesCheckBox// Checked SVG
                      : Assets.imagesCheckBox,
                  height: 18.h,
                  width: 18.w,// Unchecked SVG
                ),
              ),
            ),
            // ),
            Gap(8.w),
            Text(Strings.bodyCare.tr,
              style: TextStyleHelper.of(context).b_16,
            ),
          ],
        ),
        Gap(13.h),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                handleCheckboxChange(2);
              },
              child: Center(
                child: SvgPicture.asset(
                  _isCheckedList[2]
                      ? Assets.imagesCheckBox// Checked SVG
                      : Assets.imagesCheckBox,
                  height: 18.h,
                  width: 18.w,// Unchecked SVG
                ),
              ),
            ),
            // ),
            Gap(8.w),
            Text(Strings.faceCare.tr,
              style: TextStyleHelper.of(context).b_16,
            ),
          ],
        ),
        Gap(13.h),

      ],
    );
  }
}
