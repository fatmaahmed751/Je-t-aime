import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/shared_preferences.dart';
import '../OnBoarding/onboarding_screen.dart';

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
      GoRouter.of(context).goNamed(OnBoardingScreen.routeName);
      if(SharedPref.isLogin()){

      }else{

      }
    }
  }
}
