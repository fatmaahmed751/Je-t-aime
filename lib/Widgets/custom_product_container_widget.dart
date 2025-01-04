import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/ProductDetails/product_details_screen.dart';
import 'package:je_t_aime/Widgets/toast_helper.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../Utilities/strings.dart';
import '../generated/assets.dart';
class CustomProductContainerWidget extends StatelessWidget{
  const CustomProductContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.pushNamed(ProductDetailsScreen.routeName);
      },
      child: Container(
        height: 215.h,
        width: 175.w,
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.15),
          ),
          boxShadow: [
            BoxShadow(
                color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.16),
                blurRadius:2,
                spreadRadius: 1
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w ,vertical: 16.h),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Gap(40.w),
                  SizedBox(
                    height: 113.h,
                    width: 45.w,
                    child: Image.asset(
                      Assets.imagesProduct,
                      alignment: Alignment.center,
                      //  fit: BoxFit.cover,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          bottom:0.h
                      ),
                      child: GestureDetector(
                        onTap: (){
                          ToastHelper.showSuccess(
                            context: context,
                            message: Strings.addToFavoriteSuccess.tr,
                         icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
                         height:50.h,
                         fit: BoxFit.cover,),

                            backgroundColor: ThemeClass.of(context).primaryColor,
                          );
                        },
                          child: SvgPicture.asset(Assets.imagesHeartBroken)),
                    ),
                  ),
                ],
              ),
            ),
            Text(
                Strings.productDesc.tr,
                style: TextStyleHelper.of(context).b_14.copyWith(
                    color: ThemeClass.of(context).mainBlack
                )
            ),
            Expanded(
              child: Padding(
                padding:  EdgeInsetsDirectional.symmetric(
                    horizontal: 16.w) ,
                child: Row(
                  children: [
                    Text("350 ${Strings.jod.tr}" ,
                      style: TextStyleHelper.of(context).h_16.copyWith(
                          color: ThemeClass.of(context).primaryColor
                      ),),
                    const Spacer(),
                GestureDetector(
                  onTap: (){
                    ToastHelper.showSuccess(
                      context: context,
                      message: Strings.addToCartSuccess.tr,
                      icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
                        height:50.h,
                        fit: BoxFit.cover,),
                      backgroundColor: ThemeClass.of(context).primaryColor,
                    );
                  },
                      child: Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: ThemeClass.of(context).primaryColor,
                        ),
                        child:  Icon(Icons.add,
                          color: ThemeClass.of(context).background ,
                          size: 17,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}