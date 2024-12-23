// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:healty_corner/core/Language/locales.dart';
//
// import '../../../../Utilities/strings.dart';
// import '../../../../Utilities/text_style_helper.dart';
// import '../../../../Utilities/theme_helper.dart';
// import '../BrowseProducts/browse_products.dart';
// import 'earn_points_widget.dart';
// import 'login_rewards_container_widget.dart';
//
// class HcRewardsLogin extends StatelessWidget {
//   const HcRewardsLogin({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             LoginRewardsPoints(
//               yourPoints: Strings.points.tr,
//               textButton: Strings.browseRewards.tr,
//               onTap: () => context.pushNamed(BrowseProducts.routeName),
//             ),
//             Gap(8.h),
//             Text(
//               Strings.transactions.tr,
//               style: TextStyleHelper.of(context)
//                   .b_22
//                   .copyWith(color: ThemeClass.of(context).mainBlack),
//             ),
//             Gap(10.h),
//          ]
//         ),
//         SizedBox(
//          height: MediaQuery.sizeOf(context).height,
//             child:
//             ListView.separated(
//               itemBuilder:(context,index)=>const EarnPoints(),
//             itemCount: 10,
//             separatorBuilder: (context,index)=>Gap(10.h),))
//
//       ],
//     );
//   }
// }
