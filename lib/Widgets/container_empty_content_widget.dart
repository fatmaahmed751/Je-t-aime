import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';

class ContainerEmptyContentWidget extends StatelessWidget {
  final String image;
  final String mainText;
  final String descText;
  final Widget? button;
  const ContainerEmptyContentWidget(
      {super.key,
      required this.image,
      required this.mainText,
      required this.descText,
      this.button});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
      ),
      child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 290.h,
              width: double.infinity,
              child: SvgPicture.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              mainText,
              textAlign: TextAlign.center,
              style: TextStyleHelper.of(context)
                  .h_20
                  .copyWith(color: ThemeClass.of(context).mainBlack),
            ),
            Gap(20.h),
            SizedBox(
              //width: 382.w,
              // height: 85.h,
              child: Text(
                descText,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyleHelper.of(context)
                    .b_16
                    .copyWith(color: ThemeClass.of(context).secondaryBlackColor),
              ),
            ),
            Gap(30.h),
            button??const SizedBox(),
            Gap(170.h)
          ]),
    );
  }
}
