// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';
// import 'package:healty_corner/core/Language/locales.dart';
//
// import '../../../../Utilities/strings.dart';
// import '../../../../Utilities/text_style_helper.dart';
// import '../../../../Utilities/theme_helper.dart';
// import '../../../../generated/assets.dart';
//
// class PackagesRewardsLogin extends StatelessWidget {
//   const PackagesRewardsLogin({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//       return SizedBox(
//         height: MediaQuery.sizeOf(context).height,
//         child: ListView.separated(
//             itemBuilder: (context,index)=>const PackageName(),
//             separatorBuilder: (context,index)=> Gap(10.h),
//             itemCount: 10),
//       );
//     //   ],
//     // );
//   }
// }
//
// class PackageName extends StatelessWidget {
//   const PackageName({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       padding: EdgeInsetsDirectional.symmetric(
//           horizontal: 10.w,
//       vertical: 10.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         border: Border(
//           bottom: BorderSide(
//             color: ThemeClass.of(context).primaryColor.withOpacity(.15),
//             width: 0.1, // Thickness of the bottom border
//           ),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: ThemeClass.of(context)
//                 .primaryColor
//                 .withOpacity(0.1), // Shadow color
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Image.asset(Assets.imagesPackageImage,
//           width: 80.h,
//           height: 129.h,),
//           SizedBox(
//             width: 268.w,
//             height: 135.h,
//             child: Padding(
//               padding: EdgeInsetsDirectional.only(start:8.w,end: 7.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     Strings.packageName.tr,
//                     style: TextStyleHelper.of(context).b_16
//                        // .copyWith(color:ThemeClass.of(context).mainBlack
//                     //),
//                   ),
//                   Gap(5.h),
//                   SizedBox(
//                     width: 350.w,
//                     height:65.h,
//                     child: Text(
//                       Strings.packageDescription.tr,
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyleHelper.of(context).b_14.
//                     copyWith(color:ThemeClass.of(context).labelColor)),
//                     ),
//                   Gap(5.w),
//                   Row(
//                     children: [
//                       Text(
//                         Strings.packagePrice.tr,
//                         style: TextStyleHelper.of(context).h_18.
//                         copyWith(color:ThemeClass.of(context).primaryColor),
//                       ),
//                       const Spacer(),
//                       Container(
//                         width:35.w,
//                         height:35.h,
//                         decoration: BoxDecoration(
//                           color: ThemeClass.of(context).primaryColor,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(3.0),
//                           child: Center(
//                             child: SvgPicture.asset(
//                               Assets.imagesCartIc,color: ThemeClass.of(context).secondary,),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }