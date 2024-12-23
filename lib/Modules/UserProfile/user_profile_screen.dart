
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/UserProfile/user_profile_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Widgets/loading_screen.dart';
import '../../../Utilities/strings.dart';
import '../../../generated/assets.dart';
import '../../Utilities/shared_preferences.dart';
import '../Login/login_screen.dart';
import '../Orders/orders_screen.dart';
import '../PersonalData/personal_data_screen.dart';
import '../Policies/policies_screen.dart';
import '../Support/support_screen.dart';
import 'Widget/user_profile_container_widget.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = "UserProfile";

  const UserProfileScreen({super.key});

  @override
  createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends StateMVC<UserProfileScreen> {
  _UserProfileScreenState() : super(UserProfileController()) {
    con = UserProfileController();
  }
  late UserProfileController con;

  @override
  void initState() {
    con.init();
   // con.updateNotifications(context);
   //con.unReadNotifications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    print(SharedPref.getCurrentUser().toString());
    return Scaffold(
      // bottomNavigationBar: BottomNavBarWidget(
      //   selected: SelectedBottomNavBar.account,
      // ),
      // appBar:  CustomAppBarWidget.mainScreen(
      //
      // ),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: Padding(
              padding: EdgeInsetsDirectional.only(
                  end: 24.w, start: 24.w, bottom: 20.h),
              child:con.isLogin
                  ? ListView(
                      children: [
                        Gap(5.h),
                        Gap(20.h),
                        Gap(10.h),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(PersonalDataScreen.routeName);
                          },
                          child: UserProfileContainerWidget(
                            image: (Assets.imagesPersonal),
                            text: Strings.personalData.tr,
                          ),
                        ),
                        Gap(10.h),
                        Gap(10.h),
                        GestureDetector(
                          onTap: () {

                           context.pushNamed(OrdersScreen.routeName,
                              // extra:OrderInfoModel()
                           );
                          },
                          child: UserProfileContainerWidget(
                            image: (Assets.imagesOrders),
                            text: Strings.orders.tr,
                          ),
                        ),
                        Gap(10.h),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(SupportScreen.routeName);
                          },
                          child: UserProfileContainerWidget(
                            image: (Assets.imagesSupport),
                            text: Strings.support.tr,
                          ),
                        ),
                        Gap(10.h),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(PoliciesScreen.routeName
                           // ,extra:PoliciesModel()
                            );
                          },
                          child: UserProfileContainerWidget(
                            image: (Assets.imagesPolicies),
                            text: Strings.policy.tr,
                          ),
                        ),
                        Gap(10.h),
                        GestureDetector(
                          onTap: () async {
                            await con.changeLanguageOfApp(context);
                          },
                          child: UserProfileContainerWidget(
                            image: (Assets.imagesGlobe),
                            text: Strings.languages.tr,
                          ),
                        ),
                        Gap(10.h),
                        GestureDetector(
                          onTap: () {
                         //   con.deleteUserAccountPop(context);
                          },
                          child: UserProfileContainerWidget(
                            image: (Assets.imagesDeleteAccount),
                            text: Strings.deleteAccount.tr,
                          ),
                        ),
                        Gap(10.h),
                        GestureDetector(
                          onTap: () {
                           // con.userLogOutPop(context);
                          },
                          child: UserProfileContainerWidget(
                            image: (Assets.imagesLogout),
                            text: Strings.logOut.tr,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Gap(35.h),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(PersonalDataScreen.routeName);
                            },
                            child: UserProfileContainerWidget(
                              image: (Assets.imagesPersonal),
                              text: Strings.personalData.tr,
                            ),
                          ),



                          Gap(15.h),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(SupportScreen.routeName);
                            },
                            child: UserProfileContainerWidget(
                              image: (Assets.imagesSupport),
                              text: Strings.support.tr,
                            ),
                          ),
                          Gap(15.h),
                          GestureDetector(
                            onTap: () async {
                              await con.changeLanguageOfApp(context);
                            },
                            child: UserProfileContainerWidget(
                              image: (Assets.imagesGlobe),
                              text: Strings.languages.tr,
                            ),
                          ),
                          Gap(15.h),
                          // GestureDetector(
                          //   onTap: () {
                          //     GoRouter.of(context)
                          //         .pushNamed(LoginScreen.routeName);
                          //   },
                          //   child: UserProfileContainerWidget(
                          //     image: (Assets.imageslo),
                          //     text: Strings.login.tr,
                          //   ),
                         // ),
                        ])),
        ),
      ),
    );
  }
}
