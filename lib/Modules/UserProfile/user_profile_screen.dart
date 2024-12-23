//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:je_t_aime/Modules/UserProfile/user_profile_controller.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
// import '../../../../Widgets/loading_screen.dart';
// import '../../../Utilities/strings.dart';
// import '../../../Utilities/text_style_helper.dart';
// import '../../../Utilities/theme_helper.dart';
// import '../../../generated/assets.dart';
// import '../../Utilities/shared_preferences.dart';
// import 'Widget/change_name_and_image_widget.dart';
// import 'Widget/user_profile_container_widget.dart';
//
// class UserProfileScreen extends StatefulWidget {
//   static const routeName = "UserProfile";
//
//   const UserProfileScreen({super.key});
//
//   @override
//   createState() => _UserProfileScreenState();
// }
//
// class _UserProfileScreenState extends StateMVC<UserProfileScreen> {
//   _UserProfileScreenState() : super(UserProfileController()) {
//     con = UserProfileController();
//   }
//   late UserProfileController con;
//
//   @override
//   void initState() {
//     con.init();
//    // con.updateNotifications(context);
//    //con.unReadNotifications();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     bool isLogin=true;
//     print(SharedPref.getCurrentUser().toString());
//     return Scaffold(
//       // bottomNavigationBar: BottomNavBarWidget(
//       //   selected: SelectedBottomNavBar.account,
//       // ),
//       // appBar:  CustomAppBarWidget.mainScreen(
//       //
//       // ),
//       body: LoadingScreen(
//         loading: con.loading,
//         child: SafeArea(
//           child: Padding(
//               padding: EdgeInsetsDirectional.only(
//                   end: 24.w, start: 24.w, bottom: 20.h),
//               child:isLogin
//                   ? ListView(
//                       children: [
//                         Gap(5.h),
//                         Gap(20.h),
//                         Gap(10.h),
//                         GestureDetector(
//                           onTap: () {
//                             context.pushNamed(PersonalDataScreen.routeName);
//                           },
//                           child: UserProfileContainerWidget(
//                             image: (Assets.imagesUserIcon),
//                             text: Strings.personalData.tr,
//                           ),
//                         ),
//                         Gap(10.h),
//                         GestureDetector(
//                           onTap: () {
//                             context
//                                 .pushNamed(SecureInformationScreen.routeName);
//                           },
//                           child: UserProfileContainerWidget(
//                             image: (Assets.imagesSecureIcon),
//                             text: Strings.securityInformation.tr,
//                           ),
//                         ),
//                         Gap(10.h),
//                         GestureDetector(
//                           onTap: () {
//
//                            context.pushNamed(OrdersScreen.routeName,
//                                extra:OrderInfoModel());
//                           },
//                           child: UserProfileContainerWidget(
//                             image: (Assets.imagesClipboardText),
//                             text: Strings.orders.tr,
//                           ),
//                         ),
//                         Gap(10.h),
//                         GestureDetector(
//                           onTap: () {
//                             context.pushNamed(SupportScreen.routeName);
//                           },
//                           child: UserProfileContainerWidget(
//                             image: (Assets.imagesSupportIcon),
//                             text: Strings.support.tr,
//                           ),
//                         ),
//                         Gap(10.h),
//                         GestureDetector(
//                           onTap: () {
//                             context.pushNamed(PoliciesScreen.routeName
//                             ,extra:PoliciesModel());
//                           },
//                           child: UserProfileContainerWidget(
//                             image: (Assets.imagesPolicyIcon),
//                             text: Strings.policy.tr,
//                           ),
//                         ),
//                         Gap(10.h),
//                         GestureDetector(
//                           onTap: () async {
//                             await con.changeLanguageOfApp(context);
//                           },
//                           child: UserProfileContainerWidget(
//                             image: (Assets.imagesGlobe),
//                             text: Strings.languages.tr,
//                           ),
//                         ),
//                         Gap(10.h),
//                         GestureDetector(
//                           onTap: () {
//                             con.deleteUserAccountPop(context);
//                           },
//                           child: UserProfileContainerWidget(
//                             image: (Assets.imagesTrashIcon),
//                             text: Strings.deleteAccount.tr,
//                           ),
//                         ),
//                         Gap(10.h),
//                         GestureDetector(
//                           onTap: () {
//                             con.userLogOutPop(context);
//                           },
//                           child: UserProfileContainerWidget(
//                             image: (Assets.imagesLogoutIcon),
//                             text: Strings.logOut.tr,
//                           ),
//                         ),
//                       ],
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                           Gap(35.h),
//                           GestureDetector(
//                             onTap: () {
//                               context.pushNamed(PersonalDataScreen.routeName);
//                             },
//                             child: UserProfileContainerWidget(
//                               image: (Assets.imagesUserIcon),
//                               text: Strings.personalData.tr,
//                             ),
//                           ),
//                           Gap(15.h),
//                           GestureDetector(
//                             onTap: () {
//                               context
//                                   .pushNamed(SecureInformationScreen.routeName);
//                             },
//                             child: UserProfileContainerWidget(
//                               image: (Assets.imagesSecureIcon),
//                               text: Strings.securityInformation.tr,
//                             ),
//                           ),
//                           Gap(15.h),
//                           GestureDetector(
//                             onTap: () {
//                               context.pushNamed(OrdersScreen.routeName);
//                             },
//                             child: UserProfileContainerWidget(
//                               image: (Assets.imagesClipboardText),
//                               text: Strings.orders.tr,
//                             ),
//                           ),
//                           Gap(15.h),
//                           GestureDetector(
//                             onTap: () {
//                               context.pushNamed(SupportScreen.routeName);
//                             },
//                             child: UserProfileContainerWidget(
//                               image: (Assets.imagesSupportIcon),
//                               text: Strings.support.tr,
//                             ),
//                           ),
//                           Gap(15.h),
//                           GestureDetector(
//                             onTap: () {
//                               context.pushNamed(PoliciesScreen.routeName);
//                             },
//                             child: UserProfileContainerWidget(
//                               image: (Assets.imagesPolicyIcon),
//                               text: Strings.policy.tr,
//                             ),
//                           ),
//                           Gap(15.h),
//                           GestureDetector(
//                             onTap: () async {
//                               await con.changeLanguageOfApp(context);
//                             },
//                             child: UserProfileContainerWidget(
//                               image: (Assets.imagesGlobe),
//                               text: Strings.languages.tr,
//                             ),
//                           ),
//                           Gap(15.h),
//                           GestureDetector(
//                             onTap: () {
//                               GoRouter.of(context)
//                                   .pushNamed(LoginScreen.routeName);
//                             },
//                             child: UserProfileContainerWidget(
//                               image: (Assets.imagesLoginIcon),
//                               text: Strings.login.tr,
//                             ),
//                           ),
//                         ])),
//         ),
//       ),
//     );
//   }
// }
