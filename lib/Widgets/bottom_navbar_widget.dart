import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Favorite/favorite_screen.dart';
import 'package:je_t_aime/Modules/Home/home_screen.dart';
import 'package:je_t_aime/Modules/UserProfile/user_profile_screen.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../Modules/Notifications/notifications_screen.dart';
import '../Utilities/strings.dart';
import '../Utilities/theme_helper.dart';
import '../generated/assets.dart';

class BottomNavBarWidget extends StatelessWidget {
  final SelectedBottomNavBar selected;

  const BottomNavBarWidget({Key? key, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

      return Container(
        height: 72.h,
       decoration: BoxDecoration(
           color:ThemeClass.of(context).primaryColor,
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
          child:   BottomNavigationBar(
            //elevation:10,
            backgroundColor: ThemeClass.of(context).background,
            currentIndex: selected.index,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ThemeClass.of(context).primaryColor,
            unselectedItemColor: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.6
            ),
            onTap: (index) {
              context.pushNamed(_BottomNavBarItemModel.screens[index].routeName);
            },
            items: _BottomNavBarItemModel.screens.map((item) {
              final isSelected = item.type == selected;

              return BottomNavigationBarItem(
                icon: isSelected
                    ? _buildSelectedIcon(item, context)
                    : _buildUnselectedIcon(item, context),
                label: item.title.tr,
              );
            }).toList(),
          ),
        ),

    );
  }

  Widget _buildSelectedIcon(_BottomNavBarItemModel item, BuildContext context) {
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

  Widget _buildUnselectedIcon(
      _BottomNavBarItemModel item, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 6.h),
      child: SvgPicture.asset(
        item.iconPath,
        colorFilter:  ColorFilter.mode(ThemeClass.of(context).secondaryBlackColor.withOpacity(0.8), BlendMode.srcIn),
      ),
    );
  }
}

class _BottomNavBarItemModel {
  final String iconPath;
  final String selectedIconPath;
  final String title;
  final String routeName;
  final SelectedBottomNavBar type;

  _BottomNavBarItemModel({
    required this.iconPath,
    required this.selectedIconPath,
    required this.title,
    required this.routeName,
    required this.type,
  });

  static List<_BottomNavBarItemModel> screens = [
    home,
    favorite,
    notification,
    account,
  ];

  static _BottomNavBarItemModel home = _BottomNavBarItemModel(
    iconPath: Assets.imagesHome,
    selectedIconPath: Assets.imagesHome,
    title:Strings.home,
    routeName:HomeScreen.routeName,
    type: SelectedBottomNavBar.home,
  );

  static _BottomNavBarItemModel favorite = _BottomNavBarItemModel(
    iconPath: Assets.imagesFavNav,
    selectedIconPath: Assets.imagesFavNav,
    title: Strings.favorite,
    routeName:FavoriteScreen.routeName,
    type: SelectedBottomNavBar.favorite,
  );

  static _BottomNavBarItemModel notification = _BottomNavBarItemModel(
    iconPath: Assets.imagesNotNav,
    selectedIconPath: Assets.imagesNotNav,
    title:Strings.notification,
    routeName: NotificationsScreen.routeName,
    type: SelectedBottomNavBar.notification,
  );

  static _BottomNavBarItemModel account = _BottomNavBarItemModel(
    iconPath: Assets.imagesProfileNav,
    selectedIconPath: Assets.imagesProfileNav,
    title: Strings.profile,
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
