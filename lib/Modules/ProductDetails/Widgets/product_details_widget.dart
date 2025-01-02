import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Widgets/custom_details_side_text.dart';
import '../../../generated/assets.dart';
import '../product_details_controller.dart';

class ProductDetailsWidget extends StatefulWidget{
  const ProductDetailsWidget({super.key});

  @override
  createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends StateMVC<ProductDetailsWidget> {
  _ProductDetailsWidgetState():super(ProductDetailsController()){
    con = ProductDetailsController();
  }

  late ProductDetailsController con;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 382.w,
            height: 270.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color:ThemeClass.of(context).pinkColor,

            ),
            child: Padding(
              padding:  EdgeInsetsDirectional.symmetric(vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main product image
                  SizedBox(
                    width: 65.w,
                    height: 158.h,
                    child: Image.asset(Assets.imagesProduct,// Replace with your main image
                      fit: BoxFit.contain,
                    ),
                  ),
                  Gap(20.h), // Spacing between images
                  // Thumbnail images row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle thumbnail selection
                        },
                        child: Container(
                          width: 60.w,
                          height: 60.h,
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                            border: Border.all(
                              color: index == 0 ?ThemeClass.of(context).primaryColor :ThemeClass.of(context).labelColor,
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding:EdgeInsetsDirectional.symmetric(vertical: 8.h),
                            child: Image.asset(
                              Assets.imagesProduct, // Replace with your thumbnails
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gap(8.h),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.available.tr,
              style: TextStyleHelper.of(context)
                  .b_16
                  .copyWith(color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.8)),
            ),
            const Spacer(),
            Text(
              "4.5",
              style: TextStyleHelper.of(context)
                  .b_16
                  .copyWith(color: ThemeClass.of(context).mainBlack),
            ),
            Gap(5.w),
            SvgPicture.asset(
              width: 20.w,
              Assets.imagesStar,
            ),
          ],
        ),
        Gap(10.h),
        CustomDetailsSideTextWidget(
          text: Strings.productDesc.tr,
        ),
        Gap(16.h),
        Row(
          children: [
            Text(
              "350 ${Strings.jod.tr}",
              style: TextStyleHelper.of(context)
                  .h_16
                  .copyWith(color: ThemeClass.of(context).primaryColor),
            ),
            Spacer(),
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
                      con.decrementCounter;
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

                '${con.counter}',
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
                      con.incrementCounter;
                    },
                    child: Icon(Icons.add,
                        color: ThemeClass.of(context).background,
                        size: 16)),
              ),
            ),
          ],
        ),
        Gap(8.h),
        CustomDetailsSideTextWidget(
          text:  Strings.productDetails.tr,
        ),
        Gap(12.h),
        SizedBox(
          height:130.h,
          width:382.w,
          child: Text(
            Strings.productDetailsDesc.tr,
            style: TextStyleHelper.of(context)
                .b_16
                .copyWith(fontWeight: FontWeight.w400,color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.6)),
          ),
        ),
      ],
    );
  }
}