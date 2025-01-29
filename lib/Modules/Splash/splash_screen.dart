import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:je_t_aime/Modules/Splash/splash_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  _SplashScreenState() : super(SplashController()) {
    con = SplashController();
  }

  late SplashController con;

  @override
  void initState() {
    super.initState();
    con.init(context);

  }

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<bool>(context);
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              Assets.imagesSplashScreen,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
              child: Center(
                child: Lottie.asset(
                  "assets/images/logoJetame.json",
                  width: 380.w,
                  height: 380.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            if (!isConnected)
              Center(
                child: Text(
                  "No Internet Connection",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}