// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
// import '../../../../Utilities/text_style_helper.dart';
// import '../../../../Utilities/theme_helper.dart';
// import '../../../../Widgets/custom_button_widget.dart';
// import '../../../../Widgets/loading_screen.dart';
// import '../../../../generated/assets.dart';
// import 'not_login_reward_package_controller.dart';
//
// class NotLoginRewardsPackagesScreen extends StatefulWidget {
//   static const routeName = "NotLoginRewardsPackages";
//   const NotLoginRewardsPackagesScreen({super.key});
//
//   @override
//   createState() => _NotLoginRewardsPackagesScreen();
// }
//
// class _NotLoginRewardsPackagesScreen
//     extends StateMVC<NotLoginRewardsPackagesScreen> {
//   _NotLoginRewardsPackagesScreen() : super(NotLoginRewardsPackageController()) {
//     con = NotLoginRewardsPackageController();
//   }
//
//   late NotLoginRewardsPackageController con;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: () => context.pop(),
//             child: Container(
//               width: 48.w,
//               height: 48.h,
//               decoration: BoxDecoration(
//                   color: ThemeClass.of(context).secondary,
//                   shape: BoxShape.circle
//               ),
//               child: Center(
//                 child: SvgPicture.asset(
//                   Assets.imagesArrowBack,),
//               ),
//             ),
//           ),
//         ),
//         toolbarHeight: 100.h,
//         backgroundColor: ThemeClass.of(context).background,
//         elevation: 0.0,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {
//               },
//              child: Container(
//                 width: 48.w,
//                 height: 48.h,
//                 decoration: BoxDecoration(
//                     color: ThemeClass.of(context).secondary,
//                     shape: BoxShape.circle
//                 ),
//                 child:Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SvgPicture.asset(
//                     Assets.imagesShareIc,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: LoadingScreen(
//         loading: con.loading,
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsetsDirectional.symmetric(
//                 horizontal: 24.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Gap(15.h),
//                 ProductCarouselWidget(
//                   activeIndex: con.activeIndex,
//                   onPageChange: (index) => con.onPageChange(index),
//                   imageUrl: con.imageUrl,
//                 ),
//                 Gap(30.h),
//                 Text(
//                   Strings.packageName.tr,
//                   style: TextStyleHelper.of(context)
//                       .h_24
//                       .copyWith(color: ThemeClass.of(context).mainBlack),
//                 ),
//                 Gap(20.h),
//                 Row(children: [
//                   Text(
//                     Strings.available.tr,
//                     style: TextStyleHelper.of(context)
//                         .b_16
//                         .copyWith(color: ThemeClass.of(context).labelColor),
//                   ),
//                   const Spacer(),
//                   Text(
//                     '400 ${Strings.egp.tr}',
//                     style: TextStyleHelper.of(context).b_16.copyWith(
//                         decoration: TextDecoration.lineThrough,
//                         color: ThemeClass.of(context).labelColor),
//                   ),
//                   Gap(12.w),
//                   Text(
//                     "350 ${Strings.egp.tr}",
//                     style: TextStyleHelper.of(context).b_16.copyWith(
//                         fontWeight: FontWeight.w500,
//                         color: ThemeClass.of(context).primaryColor),
//                   ),
//                 ]),
//                 Gap(20.h),
//                 Text(
//                   Strings.productDetails.tr,
//                   maxLines: 5,
//                   style: TextStyleHelper.of(context)
//                       .h_20
//                       .copyWith(fontWeight: FontWeight.w500),
//                 ),
//                 Gap(20.h),
//                 Text(
//                   Strings.productDes.tr,
//                   style: TextStyleHelper.of(context)
//                       .b_16
//                       .copyWith(color: ThemeClass.of(context).labelColor),
//                 ),
//                 const Spacer(),
//                 CustomButtonWidget.primary(
//                     title: Strings.addToCart.tr,
//                     onTap: () {
//                       GoRouter.of(context).pushNamed(CartScreen.routeName);
//                     }),
//                 Gap(30.h)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
