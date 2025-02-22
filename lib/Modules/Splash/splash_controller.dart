
import 'package:connectivity_plus/connectivity_plus.dart';
import "package:firebase_messaging/firebase_messaging.dart";
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Splash/splash_data_handler.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Utilities/shared_preferences.dart';
import '../../Utilities/router_config.dart';
import '../../Widgets/check_internet_connection.dart';
import '../Home/home_screen.dart';
import '../Login/login_screen.dart';
import '../OnBoarding/onboarding_screen.dart';

class SplashController extends ControllerMVC {
  // singleton
  factory SplashController() {
    _this ??= SplashController._();
    return _this!;
  }
  static SplashController? _this;
  SplashController._();

getToken()async{
  String? fcm = await FirebaseMessaging.instance.getToken();
  print("$fcm");
  print("******************************************************");


}

  Future init(BuildContext context) async {
    await SplashDataHandler.getCurrentUser();
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      GoRouter.of(context).goNamed(OnBoardingScreen.routeName);
    }
    if (SharedPref.isLogin()) {
      // Handle logged-in state
    } else {
      // Handle not logged-in state
    }
  }
}
