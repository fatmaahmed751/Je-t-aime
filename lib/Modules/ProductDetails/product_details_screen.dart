import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/ProductDetails/product_details_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
                    onTap: (){
                      setState((){
                        con.isClick = !con.isClick;
                      });
                    },
                      child: con.isClick?SizedBox(
                          height: 26.h,
                          child: SvgPicture.asset(Assets.imagesFavoriteIcon)):
                      SizedBox(
                        height: 26.h,
                        child: SvgPicture.asset(Assets.imagesHeartBroken,
                        ),
                      )
                  ),
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
              const ReviewsItem(),
              Gap(8.h),
              const ReviewsItem(),
              Gap(8.h),
              CustomDetailsSideTextWidget(
                text: Strings.relatedProduct.tr,
              ),
              Gap(16.h),

            SizedBox(
              height: 220.h,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => const CustomProductContainerWidget(
                  ),
                  separatorBuilder: (context, index) => Gap(10.w),
                  itemCount:5),
            ),
              Gap(100.h)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 20.h),
          child: CustomButtonWidget.primary(
            onTap: (){
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

      ]
      ),
    );
  }
}

class ReviewsItem extends StatelessWidget {
  const ReviewsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382.w,
      //height: 154.h,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(top:10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Linda Mohamed",
                  style: TextStyleHelper.of(context)
                      .h_19
                      .copyWith(color: ThemeClass.of(context).mainBlack),
                ),
                Gap(4.h),
                RatingBar.builder(
                  initialRating: 4,
                  minRating: 1, // Minimum rating that can be given
                  direction: Axis.horizontal, // Rating direction
                  allowHalfRating: true, // Allow half-star ratings
                  itemCount: 5,
                  unratedColor: ThemeClass.of(context).labelColor,
                  itemSize: 18, // Number of stars
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemBuilder: (context, _) => SvgPicture.asset(
                    Assets.imagesFilledStar,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
            Gap(12.h),
            SizedBox(
              //height:130.h,
              width:382.w,
              child: Text(
                Strings.reviewsDesc.tr,
                style: TextStyleHelper.of(context)
                    .b_16
                    .copyWith(fontWeight: FontWeight.w400,color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.6)),
              ),
            ),
            Gap(16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Text(
                 FormatDateHelper.formatWalletDate.format(DateTime.now()),
                 style: TextStyleHelper.of(context)
                     .b_14
                     .copyWith(color: ThemeClass.of(context).mainBlack),
               ),
             ],

            ),
          ],
        ),
      ),
    );
  }
}
