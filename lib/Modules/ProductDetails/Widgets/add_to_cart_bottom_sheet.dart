import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Modules/Cart/cart_screen.dart";
import "package:je_t_aime/Modules/PopularProducts/popular_product_screen.dart";
import "package:je_t_aime/core/Language/locales.dart";

import "../../../Models/popular_products_model.dart";
import "../../../Utilities/strings.dart";
import "../../../Utilities/text_style_helper.dart";
import "../../../Utilities/theme_helper.dart";
import "../../../Widgets/custom_button_widget.dart";
import "../../../generated/assets.dart";

class AddToCartBottomSheetWidget extends StatelessWidget {
  final Function() addThisToCart;
  final List<PopularProductsModel> products;
  const AddToCartBottomSheetWidget({super.key, required this.addThisToCart, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 210.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: SvgPicture.asset(
                  Assets.imagesSubmit,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(8.h),
            Text(
                textAlign: TextAlign.center,
                Strings.additionToCart.tr,
                style: TextStyleHelper.of(context)
                    .b_16
                    .copyWith(color: ThemeClass.of(context).mainBlack)),
            Gap(12.h),
            Text(
                textAlign: TextAlign.center,
                Strings.selectWhatWant.tr,
                style: TextStyleHelper.of(context).b_16.copyWith(
                    color: ThemeClass.of(context)
                        .secondaryBlackColor
                        .withAlpha((0.7* 255).toInt()))),
            Gap(20.h),
            CustomButtonWidget.primary(
              title: Strings.goToCart.tr,
              onTap:addThisToCart
            ),
            Gap(12.h),
            Center(
              child: TextButton(
                  onPressed: () {
                    GoRouter.of(context)
                        .pushNamed(PopularProductsScreen.routeName,
                    extra:products );
                    context.pop();
                  },
                  child: Text(
                    Strings.continueShop.tr,
                    style: TextStyleHelper.of(context)
                        .h_16
                        .copyWith(color: ThemeClass.of(context).primaryColor),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
