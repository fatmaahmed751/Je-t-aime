
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Register/register_screen.dart';
import '../Modules/ForgetPassword/forget_password_screen.dart';
import '../Modules/Login/login_screen.dart';
import '../Modules/OTP/verification_otp_screen.dart';
import '../Modules/OnBoarding/onboarding_screen.dart';
import '../Modules/ResetPassword/reset_password_screen.dart';
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
        name: VerificationOtpScreen.routeName,
        path: "/${VerificationOtpScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          //final String email = state.extra as String;
          return getCustomTransitionPage(
            state: state,
            child:  VerificationOtpScreen(
            //    email:email
            ),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ForgetPasswordScreen.routeName,
        path: "/${ForgetPasswordScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const ForgetPasswordScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: RegisterScreen.routeName,
        path: "/${RegisterScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const RegisterScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),

      GoRoute(
        name: ResetPasswordScreen.routeName,
        path: "/${ResetPasswordScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
        //  final args = state.extra as Map<String, String?>;
          return getCustomTransitionPage(
            state: state,
            child: ResetPasswordScreen(
              //email: args['email'] ?? '', // Handle null case by providing a default value
             // code: args['code'] ?? '',   // Handle null case
            ),
          );
        },
        routes: const <RouteBase>[],
      ),
      // GoRoute(
      //   name: VerifiedAccountUserScreen.routeName,
      //   path: "/${VerifiedAccountUserScreen.routeName}",
      //   pageBuilder: (_, GoRouterState state) {
      //     final email = state.extra as String;
      //     return getCustomTransitionPage(
      //       state: state,
      //       child:  VerifiedAccountUserScreen(email:email,),
      //     );
      //   },
      //   routes: const <RouteBase>[],
      // ),
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





