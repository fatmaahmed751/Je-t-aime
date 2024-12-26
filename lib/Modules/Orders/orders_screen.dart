import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/container_empty_content_widget.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../generated/assets.dart';
import 'orders_controller.dart';

class OrdersScreen extends StatefulWidget {
  //final OrderInfoModel? orderInfoModel;
  static const routeName = "Orders";
  const OrdersScreen({
    super.key,
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
      appBar: CustomAppBarWidget.detailsScreen(
        title: Strings.orders.tr,
        icon: "",
      ),
      //CustomAppBarWidget.mainDetailsScreen(screenName: Strings.orders.tr),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 23.w, end: 23.w),
              child:
              // con.isLogin
              //     ? ListView.separated(
              //         physics: const BouncingScrollPhysics(),
              //         itemBuilder: (context, index) => const DetailsOfOrder(),
              //         separatorBuilder: (context, index) => Gap(8.h),
              //         itemCount: 6)
              //     :
              ContainerEmptyContentWidget(
                      image: Assets.imagesNoOrdersImage,
                      mainText: Strings.noOrders.tr,
                      descText:  Strings.exploreProducts.tr,
                      button: CustomButtonWidget.primary(
                        height: 48.h,
                          width: 155.w,
                          radius: 30.r,
                          title: con.isLogin
                              ? Strings.exploreProduct.tr
                              : Strings.joinUs.tr,
                          onTap: () {
                            // SharedPref.getCurrentUser()!
                            //         .token!
                            //         .isNotEmpty
                            //     ? GoRouter.of(context)
                            //         .pushNamed(PopularProductsScreen.routeName,)
                            //     : GoRouter.of(context).pushNamed(
                            //         RegisterScreen.routeName);
                          }),
                    )),
        ),
      ),
    );
  }
}
