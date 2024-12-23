import 'package:flutter/material.dart';
import 'package:je_t_aime/Modules/Splash/splash_controller.dart';
//import 'package:lottie/lottie.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen>  {
  _SplashScreenState() : super(SplashController()) {
    con = SplashController();
  }

  late SplashController con;


  @override
  void initState() {
    con.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(Assets.imagesSplash,
              width:double.infinity,
              fit: BoxFit.cover,
            ),
            // Padding(
            //   padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
            //   child: Center(
            //     child: Lottie.asset(
            //       'assets/images/splashImage.json',
            //       width: 380.w,
            //       height: 380.h,
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}

