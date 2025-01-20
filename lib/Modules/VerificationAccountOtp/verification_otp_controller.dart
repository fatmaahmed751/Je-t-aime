
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/VerificationAccountOtp/verification_otp_data_handler.dart';
import 'package:je_t_aime/Utilities/shared_preferences.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../Models/user_model.dart';
import '../../Utilities/router_config.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/toast_helper.dart';
import '../../generated/assets.dart';
import '../Home/home_screen.dart';
import '../ResetPassword/reset_password_screen.dart';
import 'verification_otp_screen.dart';

class VerificationOtpController extends ControllerMVC {
  // singleton
  factory VerificationOtpController() {
    _this ??= VerificationOtpController._();
    return _this!;
  }
  static VerificationOtpController? _this;
  VerificationOtpController._();
  bool loading=false,autoValidate = false;
 late final SmsRetriever smsRetriever;
  late TextEditingController pinController;
  late final FocusNode focusNode;
 int? userId ;

  @override
  void initState() {
    super.initState();
    pinController= TextEditingController();
    focusNode = FocusNode();
   smsRetriever = SmsRetrieverImpl(
        SmartAuth());
    // userId = SharedPref.getCurrentUser()?.user?.id;
    // if (userId == null) {
    //   print('User ID not found in Shared Preferences');
    // }

  }
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
  void setUserId(int userId) {
    final userId = SharedPref.getCurrentUser()?.user?.id;
  }
  void verifyCode(String code, String inputCode) {
    if (code == inputCode) {
      print('Verification successful');
    } else {
      print('Verification failed');
    }
  }

  verifyCodeToResetPassword()async {
    if (userId == null) {
      userId = SharedPref.getCurrentUser()?.user?.id; // Attempt to fetch from SharedPref
      if (userId == null) {
        print('User ID is missing');
        ToastHelper.showError(message: "User ID is required for verification.");
        return;
      }
    }
    setState((){loading=true;});
    final result = await OTPCodeDataHandler.verificationAccountCode(
     id:userId!,
      code: pinController.text,
    );
print(result);
    result.fold((l) {
      print('Failure: ${l.toString()}');
      ToastHelper.showError(message: Strings.verificationFailed.tr,
      backgroundColor:ThemeClass.of(currentContext_!).primaryColor );
    }, (r) {
      ToastHelper.showSuccess(
        context:   currentContext_!,
        message: Strings.verificationSuccess.tr,
        icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
          height:50.h,
          fit: BoxFit.cover,),

        backgroundColor: ThemeClass.of(currentContext_!).primaryColor,
      );
      currentContext_?.pushNamed(
        HomeScreen.routeName,
      );
      setState(() {});
    });
    setState(() {
      loading = false;
    });

  }



}







