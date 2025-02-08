import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Modules/Shipping/shipping_screen.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../Models/cart_item_model.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/text_style_helper.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/custom_app_bar_widget.dart";
import "../../Widgets/custom_button_widget.dart";
import "../../Widgets/empty_cart_widget.dart";
import "../../Widgets/loading_screen.dart";
import "../../generated/assets.dart";
import "cart_controller.dart";

class CartScreen extends StatefulWidget {
  static const routeName = "CartScreen";
  // final List<CartModel> products;
  const CartScreen({
    super.key,
    //   required this.products
  });

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
    super.initState();
    con.init();
  }

  @override
  Widget build(BuildContext context) {
    //  print("${con.cartProducts.first.price}");
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
        child: con.cartProducts.isEmpty
              ? const EmptyCartWidget()
            :Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ListView(
                      physics: const BouncingScrollPhysics(),
                      // alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          child: PagedListView<int, CartModel>(
                            physics: const NeverScrollableScrollPhysics(),
                            pagingController: con.pagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<CartModel>(
                              itemBuilder: (context, item, index) {
                                print(
                                    "Building Item: ${item.title}"); // Debug print
                                return ProductItem(
                                  cartModel: item,
                                  onRemoveWarning: () {
                                    con.deleteItemFromCart(context);
                                  },
                                  decrementCounter: () {
                                    con.decrementCounter(
                                        counter: con.counterValue);
                                  },
                                  incrementCounter: () async {
                                    con.incrementCounter(
                                        counter: con.counterValue);
                                  },
                                  counter: con.counterValue,
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
                        // ListView.separated(
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   itemBuilder: (context, index) {
                        //     return ProductItem(
                        //       cartModel:con.cartProducts[index] ,
                        //       onRemoveWarning: () {
                        //         con.deleteItemFromCart(context);
                        //       },
                        //       decrementCounter: () {
                        //         con.decrementCounter(counter: con.counterValue);
                        //       },
                        //       incrementCounter: () async {
                        //         con.incrementCounter(counter: con.counterValue);
                        //       },
                        //       counter: con.counterValue,
                        //     );
                        //   },
                        //   separatorBuilder: (context, index) => Gap(10.h),
                        //   itemCount: 5,
                        // ),
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
                                "${con.subtotal} ${Strings.jod.tr}",
                                style: TextStyleHelper.of(context)
                                    .b_14
                                    .copyWith(
                                        color:
                                            ThemeClass.of(context).mainBlack),
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
                              textStyle: TextStyleHelper.of(context)
                                  .h_20
                                  .copyWith(
                                    color: ThemeClass.of(context).background,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )

      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Function() onRemoveWarning;
  final Function() decrementCounter;
  final Function() incrementCounter;
  final CartModel cartModel;
  final int counter;
  const ProductItem(
      {super.key,
      required this.onRemoveWarning,
      required this.decrementCounter,
      required this.counter,
      required this.incrementCounter,
      required this.cartModel});

  @override
  Widget build(BuildContext context) {
     final int totalPrice = (cartModel.price ?? 0) * counter;
    print("imagemoooooooodel ${cartModel.image}");
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
                child: _buildImageWidget(cartModel.image),
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
                            onPressed:
                            onRemoveWarning,
                            ),
                      ],
                    ),
                  ),
                  Text(
                       "$totalPrice ${Strings.jod.tr}",
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
                              onTap:
                              decrementCounter,
                              child: Icon(Icons.remove,
                                  color: ThemeClass.of(context)
                                      .secondaryBlackColor,
                                  size: 16)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(

                         "$counter", // Display the counter value
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
                              onTap:
                              incrementCounter,
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

  Widget _buildImageWidget(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const Icon(
        Icons.image,
        size: 50,
        color: Colors.grey,
      );
    }

    // Simple URL validation (you can use a more robust validation if needed)
    if (!imageUrl.startsWith('http') && !imageUrl.startsWith('https')) {
      return const Icon(
        Icons.image,
        size: 50,
        color: Colors.grey,
      );
    }

    return Image.network(
      imageUrl,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image,
          size: 50,
          color: Colors.grey,
        );
      },
    );
  }
}
