import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Shipping/shipping_screen.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/empty_cart_widget.dart';
import '../../Widgets/loading_screen.dart';
import '../../generated/assets.dart';
import 'cart_controller.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "CartScreen";
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends StateMVC<CartScreen> {
  _CartScreenState() : super(CartController()) {
    con = CartController();
  }

  late CartController con;
  @override
  void initState() {
    con.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.cart.tr,
          icon: "",
        ),
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: Visibility(
          replacement: const EmptyCartWidget(),
          visible: con.isLike,
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  physics: const BouncingScrollPhysics(),
                  // alignment: Alignment.bottomCenter,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ProductItem(
                          onRemoveWarning: (context) {
                            con.deleteItemFromCart(context);
                          },
                          decrementCounter: () {
                            con.decrementCounter(counter: con.counterValue);
                          },
                          incrementCounter: () async {
                            con.incrementCounter(counter: con.counterValue);
                          },
                          counter: con.counterValue,
                        );
                      },
                      separatorBuilder: (context, index) => Gap(10.h),
                      itemCount: 5,
                    ),
                    Gap(150.h),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 20.h),
                  child: Row(
                    children: [
                      Container(
                        width: 90.w,
                        height: 54.h,
                        decoration: BoxDecoration(
                            color: ThemeClass.of(context).mainSecondary,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: Center(
                          child: Text(
                            "1150 ${Strings.jod.tr} ",
                            style: TextStyleHelper.of(context).b_14.copyWith(
                                color: ThemeClass.of(context).mainBlack),
                          ),
                        ),
                      ),
                      Gap(6.w),
                      InkWell(
                        onTap: () {
                          // // SharedPref.saveObjectList(list: []);
                          //  SharedPref.saveObjectList(list: con.fromShared??[]);
                          //  context.pushNamed(
                          //    ShippingScreen.routeName,
                          //      extra: {
                          //        'subtotal': con.subtotal,
                          //        'products':con.fromShared,

                          // queryParameters: {
                          //   "subtotal":con.subtotal .toString(),
                          //   "products":con.fromShared as List<BannerModel>
                          // },
                          // );
                          //ShippingScreen.routeName,extra: con.subtotal
                        },
                        child: CustomButtonWidget.primary(
                          onTap: () {
                            context.pushNamed(ShippingScreen.routeName);
                          },
                          width: 248.w,
                          height: 54.h,
                          title: Strings.checkOut.tr,
                          textStyle: TextStyleHelper.of(context).h_20.copyWith(
                                color: ThemeClass.of(context).background,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final Function(BuildContext) onRemoveWarning;
  final Function() decrementCounter;
  final Function() incrementCounter;
  final int counter;
  const ProductItem(
      {super.key,
      required this.onRemoveWarning,
      required this.decrementCounter,
      required this.counter,
      required this.incrementCounter});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 140.h,
      decoration: BoxDecoration(
        color: ThemeClass.of(context).background,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
              color:
                  ThemeClass.of(context).secondaryBlackColor.withOpacity(0.15),
              blurRadius: 1,
              spreadRadius: 0.5),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 12.w,
          top: 8.h,
          bottom: 8.h,
        ),
        child: Row(
          children: [
            Container(
              width: 96.w,
              height: 96.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: ThemeClass.of(context).containerColor),
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                child: Image.asset(Assets.imagesProduct),
              ),
            ),
            Gap(8.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 38.h,
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Strings.productDesc.tr,
                          style: TextStyleHelper.of(context).b_16.copyWith(
                              color: ThemeClass.of(context).mainBlack),
                        ),
                        const Spacer(), // Moves the delete icon to the end of the row
                        IconButton(
                          icon: SvgPicture.asset(Assets.imagesClose),
                          onPressed: () => widget.onRemoveWarning(context),
                        ),
                      ],
                    ),
                  ),
                  Text("350 ${Strings.jod.tr}",
                      style: TextStyleHelper.of(context).h_16.copyWith(
                            color: ThemeClass.of(context).primaryColor,
                          )),
                  Gap(8.h),
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: ThemeClass.of(context).secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: InkWell(
                              onTap: () {
                                widget.decrementCounter();
                              },
                              child: Icon(Icons.remove,
                                  color: ThemeClass.of(context)
                                      .secondaryBlackColor,
                                  size: 16)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          '${widget.counter}', // Display the counter value
                          style: TextStyleHelper.of(context).b_16.copyWith(
                              color: ThemeClass.of(context).mainBlack,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: ThemeClass.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: InkWell(
                              onTap: () {
                                widget.incrementCounter();
                              },
                              child: Icon(Icons.add,
                                  color: ThemeClass.of(context).background,
                                  size: 16)),
                        ),
                      ),
                    ],
                  ),
                  Gap(3.h)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
