import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Home/SearchSccreen/search_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../generated/assets.dart';
import '../Widgets/search_widget.dart';
class SearchScreen extends StatefulWidget {
  static const routeName = "searchScreen";
  final String search;
  const SearchScreen({super.key,required this.search});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}
class _SearchScreenState extends StateMVC<SearchScreen> {
  _SearchScreenState() : super(SearchScreenController()) {
    con = SearchScreenController();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.controller.text=widget.search;
  }
  late SearchScreenController con;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //  con.searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 32.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(35.h),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      context.pop();
                    },
                    child: Container(
                      width:48.w,
                      height:48.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ThemeClass.of(context).secondary
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                            Assets.imagesArrowBack),
                      ),
                    ),
                  ),
                  Gap(8.w),
                  Expanded(child:
                  SearchWidget(onSearch:(search){
                    setState((){
                      if(search!=null){
                        con.isSearch=true;
                      }
                    });
                  }, isSearch:con.isSearch,controller: con.controller,
                      onRemove: () {
                        setState(() {
                          con.controller.clear();
                        });
                      },
                      onChange: (text ) {
                        if(text!=null){
                          setState((){
                            con.isSearch=true;
                          });
                        }
                      }
                  )),

                ],
              ),
              Gap(24.h),
              // Wrap(
              //   spacing: 12.w,
              //   runSpacing: 12.h,
              //   children: [1,2,3,4,5,6,7,8,9,10,11,12].map((e) {
              //     return SizedBox(
              //         width: 183.w,
              //         child: ProductWidget(
              //         isLiked: con.isLiked,
              //           onLike: () {
              //           setState((){});
              //           con.isLiked=!con.isLiked;
              //         }, onTap: () {
              //           context.pushNamed(ProductDetailsScreen.routeName,extra:BannerModel() );
              //         }, productModel: BannerModel(), onCart: (BannerModel ) {  },));
              //   }).toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}