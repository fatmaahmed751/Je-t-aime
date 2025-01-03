import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/bottom_navbar_widget.dart';
import '../../Widgets/container_empty_content_widget.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../generated/assets.dart';
import 'Widgets/notification_item.dart';
import 'notifications_controller.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = "Notifications";

  const NotificationsScreen({
    super.key,
  });

  @override
  createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends StateMVC<NotificationsScreen> {
  _NotificationsScreenState() : super(NotificationsController()) {
    con = NotificationsController();
  }
  late NotificationsController con;
  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget.mainScreen(
          title:"",
      icon: "",),
        bottomNavigationBar: const BottomNavBarWidget(
          selected: SelectedBottomNavBar.notification,
        ),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
         child: Padding(
           padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w,vertical: 10.h),
            child:con.isLogin?
            ListView.separated(
                itemBuilder:(context,index) =>
                  const ShowNotificationItem(
                  ),
                separatorBuilder:(context,index)=> Gap(8.h),
                itemCount:6 ):
            ContainerEmptyContentWidget(
              image:Assets.imagesNoNotification ,
              mainText:Strings.notNotificationsYet.tr ,
              descText:Strings.getNotifications.tr ,
          ),
        ),
     ),
      )
    );
  }
}


