import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../Models/cart_details_model.dart";
import "../../Models/cart_item_model.dart";
import "../../Utilities/shared_preferences.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/text_style_helper.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/custom_app_bar_widget.dart";
import "../../Widgets/custom_button_widget.dart";
import "../../Widgets/empty_cart_widget.dart";
import "../../Widgets/loading_screen.dart";
import "../../generated/assets.dart";
import "../Shipping/shipping_screen.dart";
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
  late PagingController<int, CartModel> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);
    con.init(_pagingController);
    con.products;// Pass the PagingController to the controller
  }

  @override
  void dispose() {
    _pagingController.dispose(); // Dispose the PagingController here
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double subtotal = con.calculateSubtotal(con.cartProducts);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.cart.tr,
          icon: "",
        ),
      ),
      body: SafeArea(
        child: LoadingScreen(
          loading: con.loading,
          child: con.pagingController.itemList == null
              ? const Center(child: CircularProgressIndicator())
              : _pagingController.itemList!.isEmpty
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
                                  // print(
                                  //     "Building Item: ${item.title}"); // Debug print
                                  return ProductItem(
                                    cartModel: item,
                                    onRemoveWarning: () {
                                      con.deleteItemFromCart(context,item.id??0);
                                    },
                                    decrementCounter: () {
                                            setState(() {
                                              con.decrementCounter(
                                                  item); // Pass the specific cart item
                                            });

                                    },
                                    incrementCounter: () {
                                      setState(() {
                                        con.incrementCounter(
                                            item); // Pass the specific cart item
                                      });
                                    },
                                    counter: item.count??1,
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
                                  "${subtotal.toStringAsFixed(2)} ${Strings.jod.tr}",
                                  style: TextStyleHelper.of(context)
                                      .b_14
                                      .copyWith(
                                          color:
                                              ThemeClass.of(context).mainBlack),
                                ),
                              ),
                            ),
                            Gap(6.w),
                            CustomButtonWidget.primary(
                              onTap: ()async {
                              await SharedPref.saveCart(con.cartProducts);
                                context.pushNamed(ShippingScreen.routeName,
                                extra: {
                               "subtotal":  subtotal,
                                  "products":con.cartProducts,
                                },
                                );
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
                          ],
                        ),
                      ),
                    ],
                  ),
                )

        ),
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
    return Padding(
      padding:  EdgeInsetsDirectional.symmetric(vertical: 4.h),
      child: Container(
        // height: 140.h,
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: ThemeClass.of(context).secondaryBlackColor.withAlpha((0.15 * 255).toInt()),
          ),
          boxShadow: [
            BoxShadow(
                color:
                    ThemeClass.of(context).secondaryBlackColor.withAlpha((0.15 * 255).toInt()),
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
                            cartModel.title??"",
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
    if (!imageUrl.startsWith('http') && !imageUrl.startsWith('https')) {
      return const Icon(
        Icons.image,
        size: 50,
        color: Colors.grey,
      );
    }
    if (imageUrl.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        width: 50,
        height: 50,
        placeholderBuilder: (BuildContext context) => const Icon(
          Icons.image,
          size: 50,
          color: Colors.grey,
        ),
        errorBuilder: (context, error, stackTrace) {
          print("Error loading SVG: $error");
          return const Icon(
            Icons.image,
            size: 50,
            color: Colors.grey,
          );
        },
      );
    }
    // Simple URL validation (you can use a more robust validation if needed)


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
