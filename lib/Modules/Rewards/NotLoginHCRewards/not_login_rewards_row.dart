import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/strings.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';
import '../../../../generated/assets.dart';
import '../../Register/register_screen.dart';
import '../NotLoginPackageRewards/not_login_rewards_package_screen.dart';
import '../widget/browse_product_widget.dart';
import '../widget/login_rewards_container_widget.dart';
import 'not_login_hc_rewards_controller.dart';

class NotLoginRewardsScreen extends StatefulWidget{
  const NotLoginRewardsScreen({super.key});

  @override
  createState() => NotLoginRewardsScreenState();
}

class NotLoginRewardsScreenState extends StateMVC<NotLoginRewardsScreen> {

  NotLoginRewardsScreenState() : super(NotLoginRewardsRowController()) {
    con = NotLoginRewardsRowController();
  }
  late NotLoginRewardsRowController con;
  @override
  void initState() {
    con.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
          decoration: BoxDecoration(
              color: ThemeClass.of(context).secondary,
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: 10.h, horizontal: 16.w),
                width: 180.w,
                height: 48.h,
                decoration: BoxDecoration(
                    color: ThemeClass.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25)),
                clipBehavior: Clip.hardEdge,
                child: Text(
                  Strings.hcRewards.tr,
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.of(context).b_20.copyWith(
                      color: ThemeClass.of(context).mainBlack,
                      decoration: TextDecoration.none),
                ),
              ),
              GestureDetector(
                onTap: (){
            //      context.pushNamed(NotLoginRewardsPackagesScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 10.w, vertical: 10.h),
                  width: 175.w,
                  height: 55.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25)),
                  clipBehavior: Clip.hardEdge,
                  child: Text(
                    Strings.packages.tr,
                    textAlign: TextAlign.center,
                    style: TextStyleHelper.of(context).b_20.copyWith(
                        color: ThemeClass.of(context).mainBlack,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
              ),
          // LoginRewardsPoints(
          //   yourPoints:Strings.points.tr,
          //   textButton: Strings.signUp.tr,
          //   onTap:()=>  context.pushNamed(RegisterScreen.routeName),
          // ),
          Gap(10.h),
          Text(
            Strings.products.tr,
            style: TextStyleHelper.of(context).b_20
                .copyWith(color:
            ThemeClass.of(context).mainBlack),
          ),
          Gap(8.h),
          // Row(
          //   children: [
          //     Expanded(child: SearchWidget(
          //       onSearch:(search){
          //         setState((){
          //           if(search!=null){
          //             con.isSearch=true;
          //           }
          //         });
          //       }, isSearch:
          //     con.isSearch,
          //       controller: con.searchController,
          //       onRemove: () {
          //         setState(() {
          //           con.searchController.clear();
          //         });
          //       },
          //       onChange: (text ) {
          //         if(text!=null){
          //           setState((){
          //             con.isSearch=true;
          //           });
          //         }
          //       },
          //     )),
          //     Gap(12.w),
          //     Container(
          //       width:48.w,
          //       height:48.h,
          //       decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: ThemeClass.of(context).primaryColor
          //       ),
          //       child: Center(
          //         child: SvgPicture.asset(
          //             Assets.imagesFilterIc),
          //       ),
          //     )
          //   ],
          // ),
          Gap(15.h),
          // Wrap(
          //   spacing: 12.w,
          //   runSpacing: 12.h,
          //   children: con.products.map((e) {
          //     return SizedBox(
          //         width: 183.w,
          //         child: InkWell(
          //             onTap: (){
          //               context.pushNamed(ProductDetailsScreen.routeName,
          //               extra:e);
          //             },
          //             child: BrowseProductWidget(
          //               model: e,
          //             )));
          //   }).toList(),
          // ),
          // const BrowseProducts()
        ],


    );
  }
}