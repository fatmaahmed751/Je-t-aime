import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/ProductDetails/product_details_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import "../../Models/review_model.dart";
import '../../Utilities/format_date_helper.dart';
import '../../Utilities/shared_preferences.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_details_side_text.dart';
import '../../Widgets/custom_product_container_widget.dart';
import '../../generated/assets.dart';
import '../Reviews/reviews_screen.dart';
import 'Widgets/product_details_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "ProductDetails";
  const ProductDetailsScreen({
    super.key,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends StateMVC<ProductDetailsScreen> {
  _ProductDetailsScreenState() : super(ProductDetailsController()) {
    con = ProductDetailsController();
  }

  late ProductDetailsController con;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:  CustomAppBarWidget.detailsScreen(),

      body: Stack(alignment: Alignment.bottomCenter, children: [
        Padding(
          padding:
              EdgeInsetsDirectional.only(start: 20.w, end: 24.w, top: 15.h),
          child: ListView(
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
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          con.isClick = !con.isClick;
                        });
                      },
                      child: con.isClick
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
              const ProductDetailsWidget(),
              // Row(
              // //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //
              //     GestureDetector(
              //       onTap: (){
              //         con.toggleExpanded();
              //       },
              //       child: Text(
              //         Strings.seeMore.tr,
              //         style: TextStyleHelper.of(context).b_14.copyWith(
              //             decoration: TextDecoration.underline,
              //             color: ThemeClass.of(context).primaryColor),
              //       ),
              //     ),
              //   ],
              // ),
              // Gap(16.h),
              // Text(
              //  '',
              //   style: TextStyleHelper.of(context)
              //       .b_16
              //       .copyWith(color: ThemeClass.of(context).labelColor),
              //   maxLines: con.isExpanded ? null : 4,
              //   overflow:con. isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              // ),
              Gap(16.h),
              // if(con.product!=null&&con.product!.reviews.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDetailsSideTextWidget(
                    text: Strings.reviews.tr,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(ReviewsForProductScreen.routeName);
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
              // if(con.product!=null&&con.product!.reviews.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "24 ${Strings.rate.tr}",
                    style: TextStyleHelper.of(context).b_16.copyWith(
                        decoration: TextDecoration.underline,
                        color: ThemeClass.of(context)
                            .secondaryBlackColor
                            .withOpacity(0.6)),
                  ),
                  GestureDetector(
                    onTap: () {
                      con.writeRateForProduct(context);
                    },
                    child: SvgPicture.asset(Assets.imagesEdit),
                  ),
                ],
              ),
              Gap(8.h),
             // const ReviewsItem(),
              Gap(8.h),
             // const ReviewsItem(),
              Gap(8.h),
              CustomDetailsSideTextWidget(
                text: Strings.relatedProduct.tr,
              ),
              Gap(16.h),

              // SizedBox(
              //   height: 220.h,
              //   child: ListView.separated(
              //       physics: const BouncingScrollPhysics(),
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) => const CustomProductContainerWidget(
              //       ),
              //       separatorBuilder: (context, index) => Gap(10.w),
              //       itemCount:5),
              // ),
              Gap(100.h)
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 20.h),
          child: CustomButtonWidget.primary(
            onTap: () {
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


