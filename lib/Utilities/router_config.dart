
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Utilities/theme_helper.dart';
import '../Modules/Login/login_screen.dart';
import '../Modules/OnBoarding/onboarding_screen.dart';
import '../Modules/Splash/splash_screen.dart';

BuildContext? get currentContext_ => GoRouterConfig.router.routerDelegate.navigatorKey.currentContext;
class GoRouterConfig{
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: SplashScreen.routeName,
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child:  const SplashScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),

      // GoRoute(
      //   name: HomeScreen.routeName,
      //   path: "/${HomeScreen.routeName}",
      //   pageBuilder: (_, GoRouterState state) {
      //     return getCustomTransitionPage(
      //       state: state,
      //       child:  const HomeScreen(),
      //     );
      //   },
      //   routes: const <RouteBase>[],
      // ),
      //
      GoRoute(
        name: OnBoardingScreen.routeName,
        path: "/${OnBoardingScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const OnBoardingScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: "/${LoginScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const LoginScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),

    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   if(!SharedPref.isLogin()) return LoginScreen.routeName;
    //   if(state.matchedLocation == LoginScreen.routeName && SharedPref.isLogin()) return "/${HomeScreen.routeName}";
    //
    //   if(state.matchedLocation == OTPScreen.routeName && state.extra == null){
    //     return ForgetPasswordScreen.routeName;
    //   }
    //   return null;
    // },
  );


  static CustomTransitionPage getCustomTransitionPage({required GoRouterState state, required Widget child}){
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}





