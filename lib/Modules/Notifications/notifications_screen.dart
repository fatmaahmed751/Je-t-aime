import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:gap/gap.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Models/notification_model.dart";
import "package:je_t_aime/Models/notification_model.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../../Widgets/loading_screen.dart";
import "../../Models/order_model.dart";
import "../../Utilities/strings.dart";
import "../../Widgets/bottom_navbar_widget.dart";
import "../../Widgets/container_empty_content_widget.dart";
import "../../Widgets/custom_app_bar_widget.dart";
import "../../generated/assets.dart";
import "Widgets/notification_item.dart";
import "notifications_controller.dart";

class NotificationsScreen extends StatefulWidget {
  static const routeName = "Notifications";
final OrderModel orderModel;
  const NotificationsScreen({
    super.key, required this.orderModel,
  });

  @override
  createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends StateMVC<NotificationsScreen> {
  _NotificationsScreenState() : super(NotificationsController()) {
    con = NotificationsController();
  }
  late NotificationsController con;
  late PagingController<int, NotificationModel> _pagingController;
  late PagingController<int, OrderModel> _pagingOrderController;
  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);
    _pagingOrderController=PagingController(firstPageKey: 0);
    con.init(_pagingController,_pagingOrderController);
    con.notifications;
    con.orders;// Pass the PagingController to the controller
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _pagingOrderController.dispose();// Dispose the PagingController here
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print("kkkkkkkkkkkkkk${con.orders}");
    return Scaffold(
        appBar: const CustomAppBarWidget.mainScreen(
          title: "",
          icon: "",
        ),
        bottomNavigationBar: const BottomNavBarWidget(
          selected: SelectedBottomNavBar.notification,
        ),
        body:SafeArea(
          child: LoadingScreen(
            loading: con.loading,
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 20.w, vertical: 10.h),
              child:  con.pagingController.itemList == null
                  ? const Center(child: CircularProgressIndicator())
                  : _pagingController.itemList!.isEmpty
                  ?  ContainerEmptyContentWidget(
                image: Assets.imagesNoNotification,
                mainText: Strings.notNotificationsYet.tr,
                descText: Strings.getNotifications.tr,
              ) :
              PagedListView<int, NotificationModel>(
               physics: const BouncingScrollPhysics(),
                pagingController: con.pagingController,
                builderDelegate:
                PagedChildBuilderDelegate<NotificationModel>(
                  itemBuilder: (context, item, index) {
                    // final order = con.orders.firstWhere(
                    //       (o) => o.id == item.notifiableId, // Assuming notification has orderId
                    //   orElse: () => OrderModel(), // Default empty order
                    // );
                    return  ShowNotificationItem(
                    //  orderModel:order,
                      orderModel: widget.orderModel ,
                      notificationModel: con.notifications[index],
                    );
                  },
                  // firstPageProgressIndicatorBuilder: (context) {
                  //   return const Center(
                  //       child: CircularProgressIndicator());
                  // },
                  // newPageProgressIndicatorBuilder: (context) {
                  //   return const Center(
                  //       child: CircularProgressIndicator());
                  // },
                  // noItemsFoundIndicatorBuilder: (context) {
                  //   return const Center(
                  //       child: Text("No items found"));
                  // },
                  // noMoreItemsIndicatorBuilder: (context) {
                  //   return const Center(
                  //       child: Text("No more products"));
                 // },
                ),
              ),
           // ],
            //            ),
            ),
          ),
        ),
    );
  }
}
