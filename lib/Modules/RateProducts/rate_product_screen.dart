import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Modules/RateProducts/rate_product_controller.dart";
import "package:je_t_aime/core/Language/locales.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../../Utilities/strings.dart";
import "../../../Utilities/text_style_helper.dart";
import "../../../Utilities/theme_helper.dart";
import "../../../Utilities/validate.dart";
import "../../../Widgets/custom_button_widget.dart";
import "../../../Widgets/custom_textfield_widget.dart";
import "../../../generated/assets.dart";
import "../../Widgets/custom_home_details_text_widget.dart";
import "../../Widgets/loading_screen.dart";

class RateProductScreen extends StatefulWidget {

  const RateProductScreen({
    super.key,
  });

  @override
  createState() => _RateProductScreenState();
}

class _RateProductScreenState extends StateMVC<RateProductScreen> {
  _RateProductScreenState() : super(RateProductController()) {
    con = RateProductController();
  }
  @override
  void initState() {
    super.initState();
  }

  late RateProductController con;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeClass.of(context).background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: LoadingScreen(
        loading: con.loading,
        child: Form(
          key: _formKey,
          autovalidateMode: con.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                vertical: 5.h, horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(10.h),
                CustomHomeDetailsTextWidget(
                  text: Strings.yourRate.tr,
                  style: TextStyleHelper.of(context).b_20.copyWith(
                      color: ThemeClass.of(context).mainBlack,
                      fontWeight: FontWeight.w500),
                ),
                Gap(20.h),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 25,
                  unratedColor: ThemeClass.of(context).labelColor,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index) => SvgPicture.asset(
                    con.productRating >= index + 1
                        ? Assets.imagesFilledStar // Filled star SVG asset
                        : Assets.imagesUnColoredStar,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      con.productRating = rating;
                    });
                  },
                ),
                Gap(17.h),
                CustomHomeDetailsTextWidget(
                  text: Strings.comment.tr,
                  style: TextStyleHelper.of(context).b_20.copyWith(
                      color: ThemeClass.of(context).mainBlack,
                      fontWeight: FontWeight.w500),
                ),
                Gap(13.h),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    minHeight: 129.h, // Starting height
                    maxHeight: 380.h, // Maximum height to allow for expansion
                  ),
                  width: 382.w,
                  decoration: BoxDecoration(
                    color: ThemeClass.of(context).secondary.withOpacity(1),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: CustomTextFieldWidget(
                    controller: con.messageController,
                    textInputType: TextInputType.text,
                    hintStyle: TextStyle(
                        color: ThemeClass.of(context)
                            .secondaryBlackColor
                            .withOpacity(0.6)),
                    hint: Strings.writeYourComment.tr,
                    borderColor: Colors.transparent,
                    focusedBorderColor: Colors.transparent,
                    disableBorder: false,
                    maxLine: 1,
                    validator: (v) => Validate.validateNormalString(v),
                    onSave: (v) {
                      FocusScope.of(context)
                          .unfocus(); // Hide the keyboard after finishing
                    },
                  ),
                ),
                Gap(15.h),
                CustomButtonWidget.primary(
                    title: Strings.send.tr,
                    onTap: () {
                      con.postRatedSuccessfully();
                      //  context.pop();
                    }),
                Gap(25.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
