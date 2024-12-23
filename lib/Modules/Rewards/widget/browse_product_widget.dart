// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
//
// import '../../../../Utilities/strings.dart';
// import '../../../../Utilities/text_style_helper.dart';
// import '../../../../Utilities/theme_helper.dart';
//
// class BrowseProductWidget extends StatelessWidget {
//   final BannerModel model;
//   const BrowseProductWidget({super.key, required this.model});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 13.5.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: [
//           BoxShadow(
//             color: ThemeClass.of(context).primaryColor.withOpacity(.15),
//             offset: const Offset(2, 2),
//             blurRadius: 4,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: CustomNetworkImage(
//               url: model.image,
//               //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1bJeWtv-CEwrlzO09wgwE3sDUETLh5ZOzg&s',
//               height: 111.h,
//               width: 148.w,
//               radius: 0,
//             ),
//           ),
//           Gap(8.h),
//           Text(
//             model.name!,
//             style: TextStyleHelper.of(context)
//                 .h_16
//                 .copyWith(fontWeight: FontWeight.w500),
//           ),
//           Gap(8.h),
//           Text(
//             "${model.price ?? 0} ${Strings.egp.tr}",
//             style: TextStyleHelper.of(context).h_16.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: ThemeClass.of(context).labelColor),
//           ),
//           Gap(12.h),
//           GestureDetector(
//             onTap: () {},
//             child: Container(
//               height: 39.h,
//               decoration: BoxDecoration(
//                 color: ThemeClass.of(context).primaryColor,
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: Center(
//                 child: Text(
//                   Strings.replace.tr,
//                   style: TextStyleHelper.of(context).b_16.copyWith(
//                         decoration: TextDecoration.none,
//                       ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
