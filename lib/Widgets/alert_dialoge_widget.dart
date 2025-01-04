import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import '../Utilities/strings.dart';
import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';


class AlertWarningWidget extends StatelessWidget {
  final Function()?onButtonAccept,onButtonReject;
  final String? des,titleButtonAccept,titleButtonReject,mainText;
  const AlertWarningWidget({super.key,this.mainText,  this.onButtonAccept,  this.des,  this.onButtonReject,  this.titleButtonAccept,  this.titleButtonReject});

  @override
  Widget build(BuildContext context) {
    return  Container(
     // height: 277.h,
       // height: 252.h,
      decoration: BoxDecoration(
        color: ThemeClass.of(context).background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
      start: 23.w,top: 48.h,end: 23.w,bottom: 48.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          children: [
            //Gap(32.h),
            Text(mainText??'',style: TextStyleHelper.of(context).h_16.copyWith(color:ThemeClass.of(context).mainBlack,
                fontWeight: FontWeight.w500)),
            Gap(16.h),
            SizedBox(
                width: 337.w,
               // height: 111.h,
                child: Text(des??'',style: TextStyleHelper.of(context).b_16.copyWith(color:ThemeClass.of(context).secondaryBlackColor,
                fontWeight: FontWeight.w400),)),
            Gap(30.h),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onButtonReject,
                  child: Container(
                  width: 165.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemeClass.of(context).secondary
                      ),
                        borderRadius: BorderRadius.circular(30.r),
                        color:ThemeClass.of(context).secondary
                      // ThemeClass.of(context).background.withOpacity(0.20)
                    ),
                    //  backgroundColor: ThemeClass.of(context).primaryColor,
                    child: Center(child: Text(Strings.cancel.tr,
                      style: TextStyleHelper.of(context).h_16.copyWith(
                        color: ThemeClass.of(context).secondaryBlackColor
                      ),),
                    ),
                  ),
                ),
                Gap(16.w),
                GestureDetector(
                  onTap: onButtonAccept,
                  child: Container(
                   width: 165.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                  color:ThemeClass.of(context).cancel
                      // ThemeClass.of(context).background.withOpacity(0.20)
                    ),
                    //  backgroundColor: ThemeClass.of(context).primaryColor,
                    child: Center(child: Text(Strings.logOut.tr,
                      style: TextStyleHelper.of(context).h_16.copyWith(
                        color: ThemeClass.of(context).background,
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

