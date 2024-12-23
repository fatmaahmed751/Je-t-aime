import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../../../../Utilities/strings.dart';
import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        width: 382.w,
        height: 204.h,
        decoration: BoxDecoration(
          color: ThemeClass.of(context).background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.confirmDeleteAccount.tr,
                style: TextStyleHelper.of(context).h_20.copyWith(
                  color: ThemeClass.of(context).mainBlack,
                  decoration: TextDecoration.none,
                ),
              ),
              Gap(15.h),
              Row(
                children: [
                  _dialogButton(
                    context,
                    Strings.cancel.tr,
                    ThemeClass.of(context).primaryColor,
                    onTap: () => context.pop(),
                  ),
                  Gap(10.w),
                  _dialogButton(
                    context,
                    onTap: () {
                   //  context.pushNamed(RegisterScreen.routeName);
                     context.pop();
                    },
                    Strings.yes.tr,
                    ThemeClass.of(context).mainBlack,
                    isPrimary: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dialogButton(
      BuildContext context,
      String text,
      Color textColor,
      {
        bool isPrimary = false,
        VoidCallback? onTap
      }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 155.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: isPrimary ? ThemeClass
              .of(context)
              .primaryColor : ThemeClass
              .of(context)
              .background,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyleHelper
                .of(context)
                .h_20
                .copyWith(
              color: textColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

