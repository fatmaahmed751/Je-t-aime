import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";

import "../../../Models/review_model.dart";
import "../../../Utilities/format_date_helper.dart";
import "../../../Utilities/text_style_helper.dart";
import "../../../Utilities/theme_helper.dart";
import "../../../generated/assets.dart";

class ReviewsItem extends StatelessWidget {
  final ReviewModel reviewsModel;
  const ReviewsItem({super.key, required this.reviewsModel});



  @override
  Widget build(BuildContext context) {
    print("***********${reviewsModel.userName}con");
    return Container(
      width: 382.w,
      //height: 154.h,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 reviewsModel.userName??"",
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
                  onRatingUpdate: (rating) {
                  },
                ),
              ],
            ),
            Gap(12.h),
            SizedBox(
              //height:130.h,
              width: 382.w,
              child: Text(
                reviewsModel.message??"",
                style: TextStyleHelper.of(context).b_16.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ThemeClass.of(context)
                        .secondaryBlackColor
                        .withAlpha((0.6* 255).toInt())),
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