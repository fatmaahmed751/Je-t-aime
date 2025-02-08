import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:je_t_aime/core/Language/locales.dart";

import "../../../Models/product_details_model.dart";
import "../../../Utilities/strings.dart";
import "../../../Utilities/text_style_helper.dart";
import "../../../Utilities/theme_helper.dart";
import "../../../Widgets/custom_details_side_text.dart";
import "../../../generated/assets.dart";

class ProductDetailsWidget extends StatelessWidget{
  final ProductDetailsModel model;
  final int counter;
  final void  Function() decrement;
  final void  Function() increment;
  const ProductDetailsWidget(
      {super.key,
        required this.model,
        required this.counter,
        required this.decrement,
        required this.increment,
       });

  @override
  Widget build(BuildContext context) {
    final int totalPrice = (model.price ?? 0) * counter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 382.w,
            height: 270.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: ThemeClass.of(context).pinkColor,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main product image
                  SizedBox(
                    width: 65.w,
                    height: 158.h,
                    child: Image.network(
                      model.images?.isNotEmpty == true ? model.images!.first.image ?? "" : "",

                     // widget.productsModel.image ?? "", // Network image URL
                      fit: BoxFit.cover,
                      width: 328.w,
                      height: 192.h, // Adjust height as needed
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback widget when the image fails to load
                        return  const Icon(
                            Icons.image, // Built-in icon as a fallback
                            size: 50,
                            color: Colors.grey,
                        );
                      },
                    ),
                  ),
                  Gap(20.h), // Spacing between images
                  if (model.images!= null &&
                      model.images!.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: model.images!.map((e) {
                        return Container(
                          width: 60.w,
                          height: 60.h,
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                            border: Border.all(
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 8.h),
                            child: _buildImageWidget(
                                e.toString()
                                //    "https://via.placeholder.com/150",
                        // استخدام الصورة من القائمة

                            ),
                          ),
                        );
                      }).toList(),
                    )
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
              style: TextStyleHelper.of(context).b_16.copyWith(
                  color: ThemeClass.of(context)
                      .secondaryBlackColor
                      .withOpacity(0.8)),
            ),
            const Spacer(),
            Text(
             model.averageRating ?? "0",
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
        CustomDetailsSideTextWidget(text: model.title ?? ""),
        Gap(16.h),
        Row(
          children: [
            Text(
              "$totalPrice ${Strings.jod.tr}",
              //"${model.price*counter}${Strings.jod.tr}",
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
                    onTap: decrement,
                    child: Icon(Icons.remove,
                        color: ThemeClass.of(context).secondaryBlackColor,
                        size: 16)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
              "$counter",
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
                    onTap: increment,

                    child: Icon(Icons.add,
                        color: ThemeClass.of(context).background, size: 16)),
              ),
            ),
          ],
        ),
        Gap(8.h),
        CustomDetailsSideTextWidget(
          text: Strings.productDetails.tr,
        ),
        Gap(12.h),
        SizedBox(
          //  height:130.h,
          width: 382.w,
          child: Text(
          model.desc ?? "",
            style: TextStyleHelper.of(context).b_16.copyWith(
                fontWeight: FontWeight.w400,
                color: ThemeClass.of(context)
                    .secondaryBlackColor
                    .withOpacity(0.6)),
          ),
        ),
      ],
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
