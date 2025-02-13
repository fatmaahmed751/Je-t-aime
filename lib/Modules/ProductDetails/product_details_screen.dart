import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Models/product_details_model.dart";
import "package:je_t_aime/Modules/ProductDetails/product_details_controller.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";

import "../../Utilities/shared_preferences.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/text_style_helper.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/custom_button_widget.dart";
import "../../Widgets/custom_details_side_text.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../Reviews/reviews_screen.dart";
import "../Reviews/widget/reviews_widget.dart";
import "Widgets/custom_related_product_widget.dart";
import "Widgets/product_details_widget.dart";

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "ProductDetails";
  //final PopularProductsModel popularProductsModel;
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});
//  const ProductDetailsScreen({super.key, required this.popularProductsModel});

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends StateMVC<ProductDetailsScreen> {
  ProductDetailsScreenState() : super(ProductDetailsController()) {
    con = ProductDetailsController();
  }

  late ProductDetailsController con;
  @override
  void initState() {
    super.initState();
    con.getProductDetails(productId: widget.productId);
   // con.getProductDetails(productId: widget.popularProductsModel.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Padding(
          padding:
              EdgeInsetsDirectional.only(start: 20.w, end: 24.w, top: 15.h),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Transform.flip(
                      flipX: SharedPref.getCurrentLanguage() == "ar"
                          ? true
                          : false,
                      child: SvgPicture.asset(
                        Assets.imagesArrowBack,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // GestureDetector(
                  //     onTap: () {
                  //       if (widget.popularProductsModel.isFavorite == 0) {
                  //         con.addToFavorite(
                  //             productId: widget.popularProductsModel.id ?? 0,
                  //             context: context);
                  //       }
                  //     },
                  //     child: widget.popularProductsModel.isFavorite == 1
                  //         ? SizedBox(
                  //             height: 26.h,
                  //             child:
                  //                 SvgPicture.asset(Assets.imagesFavoriteIcon))
                  //         : SizedBox(
                  //             height: 26.h,
                  //             child: SvgPicture.asset(
                  //               Assets.imagesHeartBroken,
                  //             ),
                  //           )),

               // ],
             // ),
                  GestureDetector(
                      onTap: () {
                        if (con.productDetailsModel?.isFavorite == 0) {
                          con.addToFavorite(
                              productId: con.productDetailsModel?.id ?? 0,
                              context: context);
                        }
                      },
                      child: con.productDetailsModel?.isFavorite == 1
                          ? SizedBox(
                          height: 26.h,
                          child:
                          SvgPicture.asset(Assets.imagesFavoriteIcon))
                          : SizedBox(
                        height: 26.h,
                        child: SvgPicture.asset(
                          Assets.imagesHeartBroken,
                        ),
                      )),
                ],
              ),
              Gap(10.h),
              ProductDetailsWidget(
                  decrement: con.decrementCounter,
                  increment: con.incrementCounter,
                  counter: con.counter,
                  model: con.productDetailsModel ?? ProductDetailsModel()),

              Gap(16.h),
              //if(con.productDetailsModel!=null&&con.productDetailsModel?.reviews!= null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDetailsSideTextWidget(
                    text: Strings.reviews.tr,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(ReviewsForProductScreen.routeName,
                          extra: widget.productId);
                      //con.getProductDetails(productId: widget.popularProductsModel.id!);
                    },
                    child: Text(
                      Strings.viewAll.tr,
                      style: TextStyleHelper.of(context).b_14.copyWith(
                          decoration: TextDecoration.underline,
                          color: ThemeClass.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
              Gap(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///TODO
                  Text(
                    "24 ${Strings.rate.tr}",
                    style: TextStyleHelper.of(context).b_16.copyWith(
                        decoration: TextDecoration.underline,
                        color: ThemeClass.of(context)
                            .secondaryBlackColor
                            .withAlpha((0.6 * 255).toInt())),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (SharedPref.getCurrentUser()?.token != null &&
                          SharedPref.getCurrentUser()!.token!.isNotEmpty) {
                        con.writeRateForProduct(context,widget.productId);
                      } else {
                        con.unLoginWidget(context);
                      }
                    },
                    child: SvgPicture.asset(Assets.imagesEdit),
                  ),
                ],
              ),
              Gap(8.h),
              if (con.productDetailsModel != null &&
                  con.productDetailsModel!.reviews != null)
                ReviewsItem(reviewsModel: con.productDetailsModel!.reviews!),
              Gap(8.h),
              CustomDetailsSideTextWidget(
                text: Strings.relatedProduct.tr,
              ),
              Gap(16.h),

              SizedBox(
                height: 220.h,
                child: con.productDetailsModel == null
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            CustomRelatedProductWidget(
                          onFavoritePressed: () {},
                          productsModel:
                              con.productDetailsModel!.relatedProducts[index],
                        ),
                        separatorBuilder: (context, index) => Gap(10.w),
                        itemCount:
                            con.productDetailsModel!.relatedProducts.length,
                      ),
              ),

              Gap(100.h)
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 20.h),
          child:CustomButtonWidget.primary(
            onTap: () async {
              if (con.productDetailsModel == null) {
                ToastHelper.showError(message: "Product details are not available");
                return;
              }

              // Fetch the cart data from SharedPreferences
              final isProductInCart = await con.isProductInCart(con.productDetailsModel!.id??0);

              if (isProductInCart) {
                // Product is already in the cart, show a message
                ToastHelper.showError(message: "Product is already in the cart");
                return;
              }

              // Open the bottom sheet to confirm adding the product
              con.addToCartSheet(context);
            },
            width: 382.w,
            height: 54.h,
            title: Strings.addToCart.tr,
            textStyle: TextStyleHelper.of(context).h_20.copyWith(
              color: ThemeClass.of(context).background,
            ),
          ),
        ),
      ]),
    );
  }
}
