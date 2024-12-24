import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../Utilities/shared_preferences.dart';
import '../Utilities/strings.dart';
import '../Utilities/theme_helper.dart';
import '../generated/assets.dart';
import 'custom_app_bar_text_widget.dart';
import 'custom_details_app_bar_text_widget.dart';

enum _AppBarType { main, mainDetails, details,secondary,secondaryGradient }

//
class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final _AppBarType _appBarType;
  final String screenName;
  final List<Widget>? actions;
  final String title;
  final String icon;
  final void Function()? onPressed;
//
  const CustomAppBarWidget.mainScreen(

      // final void Function()? onPressed,
      {Key? key,
      this.onPressed,
      required this.title,
      required this.icon,
      this.actions})
      : _appBarType = _AppBarType.main,
        screenName = title,
        //actions = const [],
        super(key: key);
//
  const CustomAppBarWidget.detailsScreen({
    Key? key,
    required this.title,
    required this.icon,
    this.actions,
    this.onPressed,
  })  : _appBarType = _AppBarType.mainDetails,
        screenName = title,
        super(key: key);
//
  const CustomAppBarWidget.secondaryGradient({
    Key? key,
    required this.title,
    this.onPressed, required this.icon,
  })  : _appBarType = _AppBarType.secondaryGradient,
        screenName = title,
        actions = const [],
        super(key: key);

  const CustomAppBarWidget.gradientDetails({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  })  : _appBarType = _AppBarType.details,
        screenName = title,
        actions = const [],
        super(key: key);

  const CustomAppBarWidget.secondaryAppBar({
    Key? key,
    required this.title,
    required this.icon,

    this.onPressed, this.actions,
  })  : _appBarType = _AppBarType.secondary,
        screenName = title,


        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (_appBarType) {
      case _AppBarType.main:
        return MainAppBarWidget(
            title: screenName, onPressed: onPressed, icon: icon, actions: []
            //  () {  },
            );
      case _AppBarType.secondaryGradient:
        return SecondaryGradientAppBarWidget(
            title: screenName,
          //  () {  },
        );
      case _AppBarType.mainDetails:
        return MainDetailsAppBarWidget(
          title: screenName,
          onPressed: onPressed,
          icon: icon,
          actions: actions,
        );
      case _AppBarType.details:
        return GradientAppBarWidget(
          title: screenName,
          onPressed: onPressed,
          icon: icon,
        );
      case _AppBarType.secondary:
        return SecondaryAppBarWidget(
          title: screenName,
          icon: icon,
        );
      default:
        return Container();
    }
  }

//
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight +35.h);
// }
}

class MainAppBarWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final String icon;
  final List<Widget>? actions;
  const MainAppBarWidget(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 390.h,
      child: Stack(
        children: [
          Container(
            height: 280.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: ThemeClass.backgroundGradiant,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 16.w, top: 60.h, end: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //const SizedBox(width: 15,),

                  CustomAppBarMainTextWidget(
                      text: Strings.hello.tr),
                  Gap(8.w),
                 Image.asset(Assets.imagesFace,
                   width: 24.w,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child:Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                            color: ThemeClass.of(context).background,
                            borderRadius: BorderRadius.circular(30.r)
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 6.w,
                              vertical: 6.h),
                          child: SvgPicture.asset(Assets.imagesRewards,
                          ),
                        )),
                  ),
                  Gap(8.w),
                  GestureDetector(
                    onTap: () {},
                    child:Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                            color: ThemeClass.of(context).background,
                            borderRadius: BorderRadius.circular(30.r)
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 6.w,
                              vertical: 6.h),
                          child: SvgPicture.asset(Assets.imagesShop,
                          ),
                        )),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     //const SizedBox(width: 15,),
      //
      //     CustomAppBarMainTextWidget(
      //         text: Strings.hello.tr),
      //     SvgPicture.asset(Assets.imagesSmillingFace),
      //     const Spacer(),
      //
      //
      //   ],
      // ),
    );
  }
}

class MainDetailsAppBarWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final String? icon;
  final List<Widget>? actions;
  const MainDetailsAppBarWidget(
      {Key? key,
      required this.title,
      this.icon,
      required this.onPressed,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only( top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          IconButton(
              icon: SvgPicture.asset(Assets.imagesArrowBack), onPressed: (){
                context.pop();
          }
          ),
     Gap(16.w),
      Center(child: CustomAppBarDetailsTextWidget(text: title)),
         // Gap(50.w),
         //const Spacer(),
          // IconButton(
          //     icon: SvgPicture.asset(icon!),
          //     onPressed: () {
          //
          //     }),
         // const Spacer()

        ],
      ),
    );
  }
}

class SecondaryAppBarWidget extends StatefulWidget {
  final String title;
  final String? icon;
 // final VoidCallback? onDeleteIconToggle;
  const SecondaryAppBarWidget({
    Key? key,
    required this.title,
    this.icon,
    //this.onDeleteIconToggle

  }) : super(key: key);

  @override
  createState() => SecondaryAppBarWidgetState();
}

class SecondaryAppBarWidgetState extends State<SecondaryAppBarWidget> {
  // SecondaryAppBarWidgetState ():super(MediaController()){
  //   con = MediaController();
  // }
  //
  // late MediaController con;
  // bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    print('SecondaryAppBarWidget rebuild with icon: ${widget.icon}');
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, top: 50.h),
      child: Container(
       // color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(5.w),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor:
                    ThemeClass.of(context).background.withOpacity(0.20),
                child: Transform.flip(
                  flipX: SharedPref.getCurrentLanguage() == "ar" ? true : false,
                  child: SvgPicture.asset(
                    Assets.imagesArrowBack,
                  ),
                ),
              ),
            ),
            Gap(90.w),
            // Center(child: CustomAppBarMainTextWidget(text: widget.title),
            // ),
            Spacer(),
            if (widget.icon != null && widget.icon!.isNotEmpty)
            Padding(
              padding:  EdgeInsetsDirectional.symmetric(horizontal:12.w),
              child: IconButton(
                  icon: SvgPicture.asset(widget.icon!),
                  onPressed: () {
                    print('hhhhhhhhhhhhh;');
                 //  con.toggleDeleteIcon();
                  }),
            ),

          ],
        ),
      ),
    );
  }
}

class SecondaryGradientAppBarWidget extends StatelessWidget {
  final String title;
  const SecondaryGradientAppBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, top: 50.h),
      child: Container(
      // color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(5.w),
            // InkWell(
            //   onTap: () {
            //    context.pop();
            //   },
            //   child: CircleAvatar(
            //     radius: 18.r,
            //    // backgroundColor:
            //    // ThemeClass.of(context).blueColor,
            //     child:  Transform.flip(
            //       flipX: SharedPref.getCurrentLanguage() == "ar" ? true : false,
            //       child: SvgPicture.asset(
            //         Assets.imagesDarkArrowBack,
            //       ),
            //     ),
            //   ),
            // ),
         Spacer(),

            Spacer()

          ],
        ),
      ),
    );
  }
}
class GradientAppBarWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final String? icon;

  const GradientAppBarWidget({
    Key? key,
    required this.title,
  this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, top:50.h),
      child: Container(
 // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
           IconButton(icon: SvgPicture.asset(icon!), onPressed: onPressed),
           Gap(50.w),

           const Spacer(),

          ],
        ),
      ),
    );
  }
}
