import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:je_t_aime/Utilities/text_style_helper.dart';
import '../Utilities/router_config.dart';
import '../Utilities/theme_helper.dart';
import '../generated/assets.dart';

class ToastHelper{
  static final FToast _fToast = FToast();

  static void init(BuildContext context) {
    _fToast.init(context);
  }
  static Future showError({required String? message,Color? backgroundColor})async{
    await Fluttertoast.showToast(
      msg: message??"error",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor:backgroundColor??ThemeClass.of(currentContext_!).primaryColor,
      textColor: Colors.white,
      fontSize: 16.sp,
    );
  }

  static void _showCustomToast({
    required String message,
    required Color backgroundColor,
    required Widget? icon,
  }) {
    Widget toast = Container(
      padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        icon?? const Icon(Icons.error, color: Colors.white),
         Gap(6.w),
          Flexible(
            child: Text(
              message,
              style: TextStyleHelper.of(currentContext_!).b_16.copyWith(
                color: ThemeClass.of(currentContext_!).labelColor
              ),
            ),
          ),
        ],
      ),
    );

    _fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
     // toastLength: Toast.LENGTH_LONG,
      toastDuration: const Duration(seconds: 2),
    );
  }
  static Future showSuccess({required String? message,Color? backgroundColor,required Widget icon})async{
     _showCustomToast(
      message: message??"success",
      backgroundColor: backgroundColor??ThemeClass.of(currentContext_!).primaryColor,
      icon:icon
    );
    Fluttertoast.showToast(
        msg: message??"success",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: backgroundColor??ThemeClass.of(currentContext_!).primaryColor,
        textColor: Colors.white,
        fontSize: 16.sp
    );
  }
}