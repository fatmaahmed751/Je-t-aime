import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/strings.dart';
import '../../../Widgets/container_empty_content_widget.dart';
import '../../../Widgets/custom_app_bar_widget.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../generated/assets.dart';
import '../../Register/register_screen.dart';

class NotLoginRewardsWidget extends StatefulWidget{
  const NotLoginRewardsWidget({super.key});

  @override
  createState() => NotLoginRewardsWidgetState();
}

class NotLoginRewardsWidgetState extends StateMVC<NotLoginRewardsWidget> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body: Column(
      //  mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(50.h),
          ContainerEmptyContentWidget(
            image:Assets.imagesNoRewards ,
            mainText:Strings.noRewards.tr ,
            descText:Strings.noRewardsDesc.tr  ,
            button:CustomButtonWidget.primary(
                height: 48.h,
                width: 155.w,
                radius: 30.r,
                title:
                   Strings.login.tr,
                onTap: () {
                  GoRouter.of(context)
                        .pushNamed(RegisterScreen.routeName);

                }),
     ),

        ],

     ),
    );
  }
}