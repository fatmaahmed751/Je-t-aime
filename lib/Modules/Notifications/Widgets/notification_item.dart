import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "package:provider/provider.dart";
import "../../../../Utilities/text_style_helper.dart";
import "../../../../Utilities/theme_helper.dart";

import "../../../Models/notification_model.dart";
import "../../../Models/order_model.dart";
import "../../../Utilities/strings.dart";
import "../../../Widgets/toast_helper.dart";
import "../../../generated/assets.dart";
import "../../ShowOrderDetails/show_order_screen.dart";
import "../notification_count_provider.dart";
import "../notifications_controller.dart";

class ShowNotificationItem extends StatefulWidget {
  final NotificationModel notificationModel;
  final OrderModel orderModel;
  const ShowNotificationItem({
    super.key, required this.notificationModel, required this.orderModel,
  });

  @override
  createState() => ShowNotificationItemState();
}

class ShowNotificationItemState extends StateMVC<ShowNotificationItem> {
  ShowNotificationItemState() : super(NotificationsController()) {
    con = NotificationsController();
  }

  late NotificationsController con;
  int notificationIsRead = 0;

  @override
  void initState() {
    super.initState();
    notificationIsRead = widget.notificationModel.isRead!;
  }

  Future<void> markNotificationAsRead() async {
    if (notificationIsRead==0) {
      setState(() {
        notificationIsRead = 1;
        widget.notificationModel.isRead = 1;
      });
      await con.allReadNotifications(orderId: widget.notificationModel.typeId??0,
          notificationId: widget.notificationModel.id??"" );
      final notificationProvider = Provider.of<NotificationCountProvider>(context, listen: false);
      await notificationProvider.decrementChatTotalCount(singleCount: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("isss reaaad${notificationIsRead}");
    return GestureDetector(
      onTap: () async {
       await markNotificationAsRead();

      },
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 5.h),
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
              color: notificationIsRead==1
                  ? ThemeClass.of(context).labelColor
                  : ThemeClass.of(context).mainSecondary,
              borderRadius: BorderRadius.circular(30.r)),
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 10.w, vertical: 3.h),
            child: Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: ThemeClass.of(context).pinkColor
                      // ThemeClass.of(context).pinkColor
                      ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 18.w, vertical: 18.h),
                    child: SvgPicture.asset(
                      Assets.imagesNotificationIcon,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ),
                Gap(8.w),
                SizedBox(
                  width: 245,
                  //height: 80.h,
                  child: Center(
                    child: Text(
                      "${widget.notificationModel.description}",
                      style: TextStyleHelper.of(context)
                          .b_16
                          .copyWith(color: ThemeClass.of(context).mainBlack),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
