// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:healty_corner/core/Language/locales.dart';
//
// import '../../../../Utilities/strings.dart';
// import '../../../../Utilities/text_style_helper.dart';
// import '../../../../Utilities/theme_helper.dart';
//
//
// class EarnPoints extends StatelessWidget {
//   const EarnPoints({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//           padding: EdgeInsetsDirectional.symmetric(
//               horizontal: 10.w,vertical: 20.h),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border(
//               bottom: BorderSide(
//                 color: ThemeClass.of(context).primaryColor.withOpacity(.15),
//                 width: 0.1,
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: ThemeClass.of(context)
//                     .primaryColor
//                     .withOpacity(0.1), // Shadow color
//                 blurRadius: 4,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     Strings.earnPoints.tr,
//                     style: TextStyleHelper.of(context).b_16,
//                   ),
//                   const Spacer(),
//                   Text(
//                     Strings.points.tr,
//                     style: TextStyleHelper.of(context).b_18,
//                   ),
//                 ],
//               ),
//               Gap(5.h),
//               Row(
//                 children: [
//                   Text(
//                     Strings.numberOfOrder.tr,
//                     style: TextStyleHelper.of(context)
//                         .b_14
//                         .copyWith(
//                         color: const Color(0xff7C7671)),
//                   ),
//                   const Spacer(),
//                   Text(
//                     Strings.date.tr,
//                     style: TextStyleHelper.of(context)
//                         .b_14
//                         .copyWith(
//                         color: const Color(0xff7C7671)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//
//
//
//   }
// }