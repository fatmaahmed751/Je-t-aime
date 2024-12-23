import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/OTP/verification_otp_screen.dart';
import 'package:je_t_aime/Modules/Register/register_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/shared_preferences.dart';
import '../OnBoarding/onboarding_screen.dart';
import '../ResetPassword/reset_password_screen.dart';

class SplashController extends ControllerMVC {
  // singleton
  factory SplashController() {
    _this ??= SplashController._();
    return _this!;
  }
  static SplashController? _this;
  SplashController._();



  Future init(BuildContext context)async{
    //await SplashDataHandler.getCurrentUser();
    await Future.delayed(const Duration(seconds: 3));
    if(context.mounted) {
      GoRouter.of(context).goNamed(RegisterScreen.routeName);
      if(SharedPref.isLogin()){

      }else{

      }
    }
  }
}
