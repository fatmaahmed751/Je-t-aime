// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:healty_corner/core/Language/locales.dart';
//
// import '../../../../Utilities/strings.dart';
// import '../../../../Utilities/text_style_helper.dart';
// import '../../../../Utilities/theme_helper.dart';
// import '../../../../generated/assets.dart';
//
// class LoginRewardsPoints extends StatelessWidget {
//   const LoginRewardsPoints({
//     super.key, required this.yourPoints, required this.textButton,required this.onTap,
//   });
// final String yourPoints;
// final String textButton;
//   final Function()onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SvgPicture.asset(Assets.imagesGradientContainer),
//         Padding(
//           padding:
//               EdgeInsetsDirectional.symmetric(horizontal: 25.w, vertical: 32.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 Strings.loyaltyPoints.tr,
//                 style: TextStyleHelper.of(context)
//                     .h_24
//                     .copyWith(color: ThemeClass.of(context).background),
//               ),
//               Gap(10.h),
//               Text(
//                   yourPoints,
//                   style: TextStyleHelper.of(context)
//                       .b_16
//                       .copyWith(color: ThemeClass.of(context).background)),
//               Gap(20.h),
//               GestureDetector(
//                 onTap: () {
//                 onTap();
//                 },
//                 child: Container(
//                   padding: EdgeInsetsDirectional.symmetric(
//                     vertical: 5.h,
//                   ),
//                   height: 37.h,
//                   width: 160.w,
//                   decoration: BoxDecoration(
//                       color: ThemeClass.of(context).mainBlack,
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Text(
//                     textAlign: TextAlign.center,
//                    textButton,
//                     style: TextStyleHelper.of(context)
//                         .b_16
//                         .copyWith(color: ThemeClass.of(context).background),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
