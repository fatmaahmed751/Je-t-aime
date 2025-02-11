import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Modules/ProductDetails/product_details_screen.dart";
import "package:je_t_aime/Widgets/toast_helper.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:je_t_aime/core/Language/locales.dart";

import "../../../Models/categories_product_model.dart";
import "../../../Utilities/strings.dart";
import "../../../Utilities/text_style_helper.dart";
import "../../../Utilities/theme_helper.dart";
import "../../../generated/assets.dart";



class CustomCategoryProductContainerWidget extends StatelessWidget {
  final CategoryProductModel categoryProductModel;
 // final PopularProductsModel productsModel;

  const CustomCategoryProductContainerWidget({super.key, required this.categoryProductModel});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(ProductDetailsScreen.routeName,
        extra:categoryProductModel );
      },
      child: Container(
        constraints: BoxConstraints(
          minHeight: 220.h,
          maxHeight: double.infinity,
        ),
        width: 175.w,
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: ThemeClass.of(context).secondaryBlackColor.withAlpha((0.15 * 255).toInt()),
          ),
          boxShadow: [
            BoxShadow(
                color: ThemeClass.of(context)
                    .secondaryBlackColor
                    .withAlpha((0.16 * 255).toInt()),
                blurRadius: 2,
                spreadRadius: 1),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Gap(40.w),
                    SizedBox(
                      height: 113.h,
                      width: 45.w,
                      child:Image.network (
                        categoryProductModel.image??"", // Network image URL
                        fit: BoxFit.cover,
                        width: 328.w,
                        height: 192.h, // Adjust height as needed
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback widget when the image fails to load
                          return const Icon(
                              Icons.image, // Built-in icon as a fallback
                              size: 50,
                              color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(bottom: 0.h),
                        child: GestureDetector(
                            onTap: () {
                              //   ToastHelper.showSuccess(
                              //     context: context,
                              //     message: Strings.addToFavoriteSuccess.tr,
                              //     icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
                              //       height:50.h,
                              //       fit: BoxFit.cover,),
                              //
                              //     backgroundColor: ThemeClass.of(context).primaryColor,
                              //   );
                              // }else{
                              //   ToastHelper.showSuccess(
                              //     context: context,
                              //     message: Strings.removedFromFav.tr,
                              //     icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
                              //       height:50.h,
                              //       fit: BoxFit.cover,),
                              //
                              //     backgroundColor: ThemeClass.of(context).primaryColor,
                              //   );
                              //
                              // }
                            },
                            //  ToastHelper.showSuccess(
                            //    context: context,
                            //    message: Strings.addToFavoriteSuccess.tr,
                            // icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
                            // height:50.h,
                            // fit: BoxFit.cover,),
                            //
                            //    backgroundColor: ThemeClass.of(context).primaryColor,
                            //  );
                            child: categoryProductModel.isFavorite == 1
                                ? SvgPicture.asset(Assets.imagesFavoriteIcon)
                                : SizedBox(
                              height: 27.h,
                              child: SvgPicture.asset(
                                Assets.imagesHeartBroken,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(8.h),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 14.w),
                child: Text(categoryProductModel.title??"",
                    style: TextStyleHelper.of(context)
                        .b_14
                        .copyWith(color: ThemeClass.of(context).mainBlack)),
              ),
              Gap(8.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Text(
                        "${categoryProductModel.price ?? 0} ${Strings.jod.tr}",
                        style: TextStyleHelper.of(context).h_16.copyWith(
                            color: ThemeClass.of(context).primaryColor),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          ToastHelper.showSuccess(
                            context: context,
                            message: Strings.addToCartSuccess.tr,
                            icon: SvgPicture.asset(
                              Assets.imagesSubmit,
                              width: 60.w,
                              height: 50.h,
                              fit: BoxFit.cover,
                            ),
                            backgroundColor:
                            ThemeClass.of(context).primaryColor,
                          );
                        },
                        child: Container(
                          width: 28.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: ThemeClass.of(context).primaryColor,
                          ),
                          child: Icon(
                            Icons.add,
                            color: ThemeClass.of(context).background,
                            size: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
