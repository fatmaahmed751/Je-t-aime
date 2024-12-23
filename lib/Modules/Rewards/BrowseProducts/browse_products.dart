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
import '../../../../Widgets/loading_screen.dart';
import '../../../../generated/assets.dart';
import 'browse_products_controller.dart';

class BrowseProducts extends StatefulWidget {
  static const routeName = "browseProducts";
   const BrowseProducts({super.key
     //,required this.products
   });

  @override
  createState() => BrowseProductsState();
}

class BrowseProductsState extends StateMVC<BrowseProducts> {
  BrowseProductsState() : super(BrowseProductsController()) {
    con = BrowseProductsController();
  }
   late BrowseProductsController con;

  @override
  void initState() {
 //  con.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //appBar: CustomAppBarWidget.mainDetailsScreen(screenName: Strings.rewards.tr, ),
      body: LoadingScreen(
        //loading: con.loading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 24.w, vertical: 15.h),
            child:ListView(
              children:  [
                Text(
                  Strings.products.tr,
                  style: TextStyleHelper.of(context).b_20
                      .copyWith(color:
                  ThemeClass.of(context).mainBlack),
                ),
                Gap(12.h),
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
                //   children: con.productsPagination.data.map((e) {
                //     return SizedBox(
                //         width: 183.w,
                //         child: InkWell(
                //             // onTap: (){
                //             //  // context.pushNamed(ProductDetailsScreen.routeName,
                //             //  extra:e );
                //             // },
                //             // child: BrowseProductWidget(
                //             //   model: e,
                //             // )
                //         )
                //     );
                //   }).toList(),
                // ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
