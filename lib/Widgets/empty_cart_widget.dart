import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import '../Utilities/strings.dart';
import '../Utilities/text_style_helper.dart';
import '../generated/assets.dart';
import 'container_empty_content_widget.dart';
import 'custom_button_widget.dart';
class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerEmptyContentWidget(
      image: Assets.imagesEmptyCart,
      mainText: Strings.yourCartEmpty.tr,
      descText:Strings.nothingInCart.tr,
    button:  CustomButtonWidget.primary(
        height: 48.h,
        width: 155.w,
        radius: 30.r,
        title:
            Strings.browseProducts.tr,
        onTap: () {
          // SharedPref.getCurrentUser()!
          //         .token!
          //         .isNotEmpty
          //     ? GoRouter.of(context)
          //         .pushNamed(PopularProductsScreen.routeName,)
          //     : GoRouter.of(context).pushNamed(
          //         RegisterScreen.routeName);
        }),

    );
  }
}
