import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';

import '../../../Utilities/strings.dart';
import '../../../generated/assets.dart';
import '../notifications_controller.dart';

class ShowNotificationItem extends StatefulWidget {
  const ShowNotificationItem({
    super.key,
  });

  @override
  createState() => ShowNotificationItemState();
}

class ShowNotificationItemState extends StateMVC<ShowNotificationItem> {
  ShowNotificationItemState() : super(NotificationsController()) {
    con = NotificationsController();
  }

  late NotificationsController con;
  bool notificationIsRead = false;

  @override
  void initState() {
    super.initState();
    notificationIsRead = notificationIsRead;
  }

  Future<void> markNotificationAsRead() async {
    if (!notificationIsRead) {
      setState(() {
        notificationIsRead = true;
        notificationIsRead = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("Rendering notification: ${widget.notificationModel.id}");
    // print("isss reaaad${isRead}");
    return GestureDetector(
      onTap: () async {
        // print("OrderInfoModel before navigating: ${widget.orderModel.toJson()}");
        await markNotificationAsRead();
      },
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 5.h),
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
              color: notificationIsRead
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
                      Strings.notificationText.tr,
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
