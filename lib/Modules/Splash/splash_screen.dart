import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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

  bool isSplashOne = false;
  bool isSplashTwo = false;
  bool isSplashThree = false;
  bool isSplashFour = false;
  bool isSplashFive = false;
  bool _isMoved = false;
  bool _isSecond = false;
  @override
  void initState() {
    con.init(context);
    super.initState();
    Future.delayed(const Duration(milliseconds:400), () {
      setState(() {
        isSplashOne = true;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          isSplashTwo = true;

        });
        Future.delayed(const Duration(milliseconds: 400), () {
          setState(() {
            isSplashThree = true;

          });
          Future.delayed(const Duration(milliseconds: 400), () {
            setState(() {
              isSplashFour = true;

            });
            Future.delayed(const Duration(milliseconds:400), () {
              setState(() {
               _isMoved = true;
              });
              Future.delayed(const Duration(milliseconds:400), () {
                setState(() {
                  isSplashFour = true;
                });
                Future.delayed(const Duration(milliseconds:400), () {
                  setState(() {
                    isSplashFive = true;
                  });
                });
              });
            });
          });
        });
      });
  });


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

            Stack(
              clipBehavior: Clip.none,
           alignment: Alignment.bottomCenter,
              children: [
            Positioned(
              bottom:370,
              child: SizedBox(
                child: Row(

                  children: [
                AnimatedOpacity(
                opacity: isSplashFive?1.0 : 0.0,
                  duration: const Duration(seconds:1),
                    child: SvgPicture.asset(Assets.imagesFullHeart)),
                       AnimatedOpacity(
                         opacity:  isSplashFour && _isMoved && !isSplashFive ?1.0 : 0.0,
                         duration: const Duration(seconds:1),
                           child:SvgPicture.asset(
                             Assets.imagesHalfHeart)
                       )

                  ],
                    ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              top: _isMoved ? 300 : 100,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                        child: AnimatedOpacity(
                            opacity: isSplashOne ? 1.0 : 0.0,
                            duration: const Duration(seconds:1),
                          child: Center(
                            child:SvgPicture.asset(Assets.imagesSplashOne)
                          ),
                        ),
                      ),
                      Gap(5.h),
                      Row(
                        children: [
                          AnimatedOpacity(
                            opacity: isSplashTwo ? 1.0 : 0.0,
                            duration: const Duration(seconds:1),
                            child: Center(
                                child:SvgPicture.asset(Assets.imagesSplashThree)
                            ),
                          ),
                          Gap(4.w),
                          AnimatedOpacity(
                            opacity: isSplashThree ? 1.0 : 0.0,
                            duration: const Duration(seconds:1),
                            child: Center(
                                child:SvgPicture.asset(Assets.imagesBeauty)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


