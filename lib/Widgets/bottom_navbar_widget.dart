import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Favorite/favorite_screen.dart';
import 'package:je_t_aime/Modules/Home/home_screen.dart';
import 'package:je_t_aime/Modules/UserProfile/user_profile_screen.dart';
import 'package:je_t_aime/core/Language/app_languages.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

import '../Modules/Notifications/notifications_screen.dart';
import '../Utilities/strings.dart';
import '../Utilities/theme_helper.dart';
import '../generated/assets.dart';

class BottomNavBarWidget extends StatefulWidget {
  final SelectedBottomNavBar selected;

  const BottomNavBarWidget({Key? key, required this.selected})
      : super(key: key);

  @override
 createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends StateMVC<BottomNavBarWidget> {
  // _BottomNavBarWidgetState() : super(UserProfileController()) {
  //   con = UserProfileController();
  // }
  //
  // late UserProfileController con;
  void initState() {
    super.initState();
   // con.loadCurrentLanguage(context);
  }
  int selectedLanguage = 1;
  // late List<_BottomNavBarItemModel> items;


  // void update() {
  //   setState(() {
  //     items=[
  //     _BottomNavBarItemModel(
  //     iconPath: Assets.imagesHome,
  //     selectedIconPath: Assets.imagesHome,
  //     title:Strings.home,
  //     routeName:HomeScreen.routeName,
  //     type: SelectedBottomNavBar.home,
  //     ),
  //     _BottomNavBarItemModel(
  //     iconPath: Assets.imagesFavNav,
  //     selectedIconPath: Assets.imagesFavNav,
  //     title: Strings.favorite,
  //     routeName:FavoriteScreen.routeName,
  //     type: SelectedBottomNavBar.favorite,
  //     ),
  //     _BottomNavBarItemModel(
  //     iconPath: Assets.imagesNotNav,
  //     selectedIconPath: Assets.imagesNotNav,
  //     title:Strings.notification,
  //     routeName: NotificationsScreen.routeName,
  //     type: SelectedBottomNavBar.notification,
  //     ),
  //
  //     ];
  //
  //   });
  //
  // }
  @override
  Widget build(BuildContext context) {

      return Container(
        height: 72.h,
       decoration: BoxDecoration(
           color:ThemeClass.of(context).background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            boxShadow:  [

                BoxShadow(
                    color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.16),
                    blurRadius:0.5,
                    spreadRadius: 0.5
                ),
              ],
            ),
        child: ClipRRect(
            borderRadius: BorderRadius.vertical(
      top: Radius.circular(30.r),
      ),

            child:  BottomNavigationBar(
              //elevation:10,
              backgroundColor: ThemeClass.of(context).background,
              currentIndex: widget.selected.index,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ThemeClass.of(context).primaryColor,
              unselectedItemColor: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.6
              ),
              onTap: (index) {
                context.pushNamed(BottomNavBarItemModel.screens[index].routeName);
              },
              items: BottomNavBarItemModel.screens.map((item) {
                final isSelected = item.type == widget.selected;
                //final appLanguage = Provider.of<AppLanguage>(context, listen: false);
               // final translatedLabel = appLanguage.translate(item.title);

               final currentLanguage = Provider.of<AppLanguage>(context, listen: false).appLang;
                // selectedLanguage = currentLanguage == Languages.en ? 1 : 2;
                return BottomNavigationBarItem(
                  icon: isSelected
                      ? buildSelectedIcon(item, context)
                      : buildUnselectedIcon(item, context),
                  label: item.title.tr,
                );
               //   item.title.tr,
               // );
              }).toList(),
            ),
          ),


    );
  }

  Widget buildSelectedIcon(BottomNavBarItemModel item, BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 6.h),
        child: SvgPicture.asset(
          item.selectedIconPath,
          colorFilter:  ColorFilter.mode(ThemeClass.of(context).primaryColor, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget buildUnselectedIcon(
      BottomNavBarItemModel item, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 6.h),
      child: SvgPicture.asset(
        item.iconPath,
        colorFilter:  ColorFilter.mode(ThemeClass.of(context).secondaryBlackColor.withOpacity(0.8), BlendMode.srcIn),
      ),
    );
  }
}


class BottomNavBarItemModel {
  final String iconPath;
  final String selectedIconPath;
  final String title;
  final String routeName;
  final SelectedBottomNavBar type;

  BottomNavBarItemModel({
    required this.iconPath,
    required this.selectedIconPath,
    required this.title,
    required this.routeName,
    required this.type,
  });

  static List<BottomNavBarItemModel> screens = [
    home,
    favorite,
    notification,
    account,
  ];

  static BottomNavBarItemModel home =
  BottomNavBarItemModel(
    iconPath: Assets.imagesHome,
    selectedIconPath: Assets.imagesHome,
    title:Strings.home.tr,
    routeName:HomeScreen.routeName,
    type: SelectedBottomNavBar.home,
  );

  static BottomNavBarItemModel favorite = BottomNavBarItemModel(
    iconPath: Assets.imagesFavNav,
    selectedIconPath: Assets.imagesFavNav,
    title: Strings.favorite.tr,
    routeName:FavoriteScreen.routeName,
    type: SelectedBottomNavBar.favorite,
  );

  static BottomNavBarItemModel notification = BottomNavBarItemModel(
    iconPath: Assets.imagesNotNav,
    selectedIconPath: Assets.imagesNotNav,
    title:Strings.notification.tr,
    routeName: NotificationsScreen.routeName,
    type: SelectedBottomNavBar.notification,
  );

  static BottomNavBarItemModel account = BottomNavBarItemModel(
    iconPath: Assets.imagesProfileNav,
    selectedIconPath: Assets.imagesProfileNav,
    title: Strings.profile.tr,
    routeName: UserProfileScreen.routeName,
    type: SelectedBottomNavBar.account,
  );
}

enum SelectedBottomNavBar {
  home,
  favorite,
  notification,
  account,
}
