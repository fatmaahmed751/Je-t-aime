// import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
// import 'package:je_t_aime/Modules/Home/home_screen.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
// import '../../Utilities/shared_preferences.dart';
//
// class SplashController extends ControllerMVC {
//   // singleton
//   factory SplashController() {
//     _this ??= SplashController._();
//     return _this!;
//   }
//   static SplashController? _this;
//   SplashController._();
//
//   Future init(BuildContext context) async {
//     //await SplashDataHandler.getCurrentUser();
//     await Future.delayed(const Duration(seconds: 3));
//     if (context.mounted) {
//       GoRouter.of(context).goNamed(HomeScreen.routeName);
//       if (SharedPref.isLogin()) {
//       } else {}
//     }
//   }
// }
import 'package:connectivity_plus/connectivity_plus.dart';
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

 //  final Connectivity connectivity = Connectivity();
 // // final ConnectivityService connectivityService = ConnectivityService();
 //  bool isConnected = true;
 //  Future<void> checkInternetConnection() async {
 //    var connectivityResult = await connectivity.checkConnectivity();
 //    setState(() {
 //        isConnected = connectivityResult != ConnectivityResult.none;
 //      });
 //
 //      if (!isConnected) {
 //        showNoInternetDialog();
 //      }

  //}

  void showNoInternetDialog() {
    showDialog(
      context: currentContext_!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Internet Connection"),
          content: Text("Please check your internet connection and try again."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future init(BuildContext context) async {
   // await checkInternetConnection();
    await SplashDataHandler.getCurrentUser();
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
        GoRouter.of(context).goNamed(HomeScreen.routeName);
      }
      if (SharedPref.isLogin()) {
        // Handle logged-in state
      } else {
        // Handle not logged-in state
      }
    }
  }


