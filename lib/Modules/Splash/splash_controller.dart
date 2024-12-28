import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/ChangePassword/change_password_screen.dart';
import 'package:je_t_aime/Modules/Favorite/favorite_screen.dart';
import 'package:je_t_aime/Modules/Home/home_screen.dart';
import 'package:je_t_aime/Modules/Notifications/notifications_screen.dart';
import 'package:je_t_aime/Modules/OTP/verification_otp_screen.dart';
import 'package:je_t_aime/Modules/Orders/orders_screen.dart';
import 'package:je_t_aime/Modules/Register/register_screen.dart';
import 'package:je_t_aime/Modules/UserProfile/user_profile_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/shared_preferences.dart';
import '../ForgetPassword/forget_password_screen.dart';
import '../OnBoarding/onboarding_screen.dart';
import '../ResetPassword/reset_password_screen.dart';
import '../Rewards/LoginRewardsScreen/login_rewards_screen.dart';

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
      GoRouter.of(context).goNamed(HomeScreen.routeName);
      if(SharedPref.isLogin()){

      }else{

      }
    }
  }
}
