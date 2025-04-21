import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import 'package:je_t_aime/Modules/Orders/widget/details_of_order_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Widgets/loading_screen.dart';
import "../../Models/order_model.dart";
import "../../Models/popular_products_model.dart";
import "../../Utilities/shared_preferences.dart";
import '../../Utilities/strings.dart';
import "../../Widgets/container_empty_content_widget.dart";
import '../../Widgets/custom_app_bar_widget.dart';
import "../../Widgets/custom_button_widget.dart";
import "../../generated/assets.dart";
import "../Home/home_screen.dart";
import "../PopularProducts/popular_product_screen.dart";
import "../Register/register_screen.dart";
import 'orders_controller.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "Orders";
  const OrdersScreen({
    super.key,
  });

  @override
  createState() => _OrdersScreenState();
}

class _OrdersScreenState extends StateMVC<OrdersScreen> {
  _OrdersScreenState() : super(OrdersController()) {
    con = OrdersController();
  }
  late OrdersController con;
  late PagingController<int, OrderModel> _pagingController;
  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);
    con.init(_pagingController);

  }

  @override
  void dispose() {
    _pagingController.dispose(); // Dispose the PagingController here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("${con.orders.length}");
    print("PagingController itemList: ${_pagingController.itemList?.length}");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.orders.tr,
          icon: "",
        ),
      ),
      //CustomAppBarWidget.mainDetailsScreen(screenName: Strings.orders.tr),
      body: SafeArea(
        child: LoadingScreen(
          loading: con.loading,
          child:
          con.pagingController.itemList == null
              ? const Center(child: CircularProgressIndicator())
              : (con.pagingController.itemList?.isEmpty ?? true)
                  ? ContainerEmptyContentWidget(
                      image: Assets.imagesNoOrdersImage,
                      mainText: Strings.noOrders.tr,
                      descText: Strings.exploreProducts.tr,
                      button: CustomButtonWidget.primary(
                          height: 48.h,
                          width: 155.w,
                          radius: 30.r,
                          title: SharedPref.getCurrentUser()?.token != null &&
                                  SharedPref.getCurrentUser()!.token!.isNotEmpty
                              ? Strings.exploreProduct.tr
                              : Strings.joinUs.tr,
                          onTap: () {
                            SharedPref.getCurrentUser()!.token!.isNotEmpty
                                ? GoRouter.of(context).pushNamed(
                                    HomeScreen.routeName)
                                : GoRouter.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                          }),
                    )
                  : Padding(
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: PagedListView<int, OrderModel>(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          pagingController: con.pagingController,
                          builderDelegate:
                              PagedChildBuilderDelegate<OrderModel>(
                            itemBuilder: (context, item, index) {
                              // print(
                              //     "Building Item: ${item.title}"); // Debug print
                              return DetailsOfOrder(
                                orderModel: item,
                              );
                            },
                            firstPageProgressIndicatorBuilder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            newPageProgressIndicatorBuilder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            noItemsFoundIndicatorBuilder: (context) {
                              return const Center(
                                  child: Text("No items found"));
                            },
                            noMoreItemsIndicatorBuilder: (context) {
                              return const Center(
                                  child: Text("No more products"));
                            },
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
