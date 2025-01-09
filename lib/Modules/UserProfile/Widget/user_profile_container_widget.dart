import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../Utilities/shared_preferences.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../generated/assets.dart';

class UserProfileContainerWidget extends StatelessWidget {
  final String image;
  final String text;
  //final Function function;
  const UserProfileContainerWidget({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 382.w,
      decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
      ),
      child: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Container(
              width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: ThemeClass.of(context).containerColor,
                    borderRadius: BorderRadius.circular(30.r)),
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 6.w,
                  vertical: 6.h),
                  child: Transform.flip(
                    flipX:SharedPref.getCurrentLanguage()=="ar"? true:false,
                    child: SvgPicture.asset(image,
                                     ),
                  ),
                )),
            Gap(10.w),
            Text(
              text,
              style: TextStyleHelper.of(context).h_20,
            ),
            const Spacer(),
            Transform.flip(
              flipX:SharedPref.getCurrentLanguage()=="ar"? true:false,
              child:  Center(
                child:   SvgPicture.asset(Assets.imagesArrowForward),
                   ),
            ),

           // SvgPicture.asset(Assets.imagesArrowForward)
          ],
        ),
      ),
    );
  }
}
