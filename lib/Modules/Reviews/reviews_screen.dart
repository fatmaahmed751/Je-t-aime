import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Modules/Reviews/reviews_controller.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/strings.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Widgets/loading_screen.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../generated/assets.dart';
import '../ProductDetails/product_details_screen.dart';

class ReviewsForProductScreen extends StatefulWidget {
  static const routeName = "reviewScreen";
  const ReviewsForProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _ReviewsForProductScreenState();
}

class _ReviewsForProductScreenState extends StateMVC<ReviewsForProductScreen> {
  _ReviewsForProductScreenState() : super(ReviewsForProductController()) {
    con = ReviewsForProductController();
  }
  late ReviewsForProductController con;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size(0,75.h),
        child: CustomAppBarWidget.detailsScreen(
          title: Strings.reviews.tr,
          icon: "",
        ),
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 23.w, vertical: 5.h),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                  children: [
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
              ListView.separated(
               shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder:  (context,index)=> const ReviewsItem(),
                  separatorBuilder: (context,index)=> Gap(8.h),
                  itemCount: 5)
                  ],
                ),
              )
        ),
        ),

    );
  }
}
