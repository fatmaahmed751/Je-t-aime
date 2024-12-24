import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../Utilities/strings.dart';
import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';
import '../generated/assets.dart';
import 'custom_button_widget.dart';

class CustomBottomSheetWidget extends StatelessWidget{
  final String text;
  final String image;
  const CustomBottomSheetWidget({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {

       return Container(
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
         ),
         child: Padding(
           padding:  EdgeInsetsDirectional.symmetric(
               horizontal: 16.w,
           vertical: 16.h),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Container(
                 height: 197.h,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(2),
                 ),
                 child: SvgPicture.asset(image),
               ),
               Gap(16.h),
               Text(
                  text,
                   style:TextStyleHelper.of(context).b_16.copyWith(
                       color: ThemeClass.of(context).labelColor
                   )
               ),
               Gap(10.h),
               CustomButtonWidget.primary(
                   title: Strings.backToHome.tr,
                   onTap: () {
                     context.pop();

                   }),
             ],
           ),
         ),
       );


  }

}