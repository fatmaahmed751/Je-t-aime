import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Utilities/shared_preferences.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/theme_helper.dart';
import '../../generated/assets.dart';
import '../UserProfile/user_profile_screen.dart';
import 'orders_controller.dart';

class OrdersScreen extends StatefulWidget {
 //final OrderInfoModel? orderInfoModel;
  static const routeName = "Orders";
  const OrdersScreen({super.key,
  //this.orderInfoModel
  });

  @override
  createState() => _OrdersScreenState();
}

class _OrdersScreenState extends StateMVC<OrdersScreen> {
  _OrdersScreenState() : super(OrdersController()) {
    con = OrdersController();
  }
  late OrdersController con;
  @override
  void initState() {
    con.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h), // Set the desired height
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 24.0.w, right: 24.w),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  context.pushNamed(UserProfileScreen.routeName);
                },
                child: Container(
                  width: 55.w,
                  height: 65.h,
                  decoration: BoxDecoration(
                      color: ThemeClass.of(context).secondary,
                      shape: BoxShape.circle),
                  child: Transform.flip(
                    flipX: SharedPref.getCurrentLanguage() == "ar" ? true : false,
                    child: Center(
                      child: SvgPicture.asset(Assets.imagesArrowBack)
                    ),
                  ),
                ),
              ),
              Gap(55.w),
              Center(
                child: Text(
                  Strings.orders.tr,
                  style: TextStyleHelper.of(context).h_20,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      //CustomAppBarWidget.mainDetailsScreen(screenName: Strings.orders.tr),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 23.w,end: 23.w,top: 15.h ),
            // child: con.orders.isNotEmpty &&
            //         SharedPref.getCurrentUser()?.token != null
            //     ? ListView.separated(
            //         physics: const BouncingScrollPhysics(),
            //         itemBuilder: (context, index) =>
            //             DetailsOfOrder(orderModel: con.orders[index]),
            //         separatorBuilder: (context, index) => Gap(5.h),
            //         itemCount:con.orders.length)
            //     : Center(
            //         child: Padding(
            //           padding: EdgeInsetsDirectional.only(
            //               start: 20.0.w, end: 20.w, top: 200.h),
            //           child: SizedBox(
            //             // width: 327.w,
            //             // height: 300.h,
            //             child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Image.asset(
            //                     Assets.imagesNoOrderImage,
            //                     width: 106.w,
            //                     height: 118.h,
            //                   ),
            //                   Gap(10.h),
            //                   Text(
            //                     Strings.noOrders.tr,
            //                     textAlign: TextAlign.center,
            //                     style: TextStyleHelper.of(context).h_24,
            //                   ),
            //                   Gap(10.h),
            //                   SizedBox(
            //                     width: 382.w,
            //                     height: 85.h,
            //                     child: Text(
            //                       Strings.exploreProducts.tr,
            //                       maxLines: 3,
            //                       textAlign: TextAlign.center,
            //                       style: TextStyleHelper.of(context)
            //                           .b_16
            //                           .copyWith(
            //                               color: ThemeClass.of(context)
            //                                   .labelColor),
            //                     ),
            //                   ),
            //                   const Spacer(),
            //                   CustomButtonWidget.primary(
            //                       title: SharedPref.getCurrentUser()?.token!= null &&
            //                           SharedPref.getCurrentUser()!.token!.isNotEmpty
            //                           ? Strings.userExploreProducts.tr
            //                           : Strings.joinUs.tr,
            //                       onTap: () {
            //                         SharedPref.getCurrentUser()!
            //                                 .token!
            //                                 .isNotEmpty
            //                             ? GoRouter.of(context)
            //                                 .pushNamed(PopularProductsScreen.routeName,)
            //                             : GoRouter.of(context).pushNamed(
            //                                 RegisterScreen.routeName);
            //                       }),
            //                   Gap(50.h)
            //                 ]),
            //           ),
            //         ),
            //       ),
          ),
        ),
      ),
    );
  }
}
