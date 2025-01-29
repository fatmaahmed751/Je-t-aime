import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'Utilities/git_it.dart';
import 'Utilities/router_config.dart';
import 'Utilities/strings.dart';
import 'Utilities/theme_helper.dart';
import 'Widgets/check_internet_connection.dart';
import 'core/Font/font_provider.dart';
import 'core/Language/app_languages.dart';
import 'core/Language/locales.dart';
import 'core/Theme/theme_provider.dart';
import 'generated/assets.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GitIt.initGitIt();
  final ConnectivityService connectivityService = ConnectivityService();
  bool isConnected = await connectivityService.checkInternetConnection();
  print("Initial Connectivity Status: $isConnected");
  HttpOverrides.global = MyHttpOverrides();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<FontProvider>(create: (_) => FontProvider()),
        StreamProvider<bool>(
          create: (_) => connectivityService.connectivityStream,
          initialData: isConnected, // Use the initial connectivity status
        ),
      ],
      child: const ConnectivityWrapper(child: EntryPoint()),
  ),
  );
}
      // child: StreamProvider<bool>(
      //   create: (_) => connectivityService.connectivityStream,
      //   initialData: true,
      //   child: const ConnectivityWrapper(child: EntryPoint()),
      // )));


class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appLan = Provider.of<AppLanguage>(context);
    final appTheme = Provider.of<ThemeProvider>(context);
    appLan.fetchLocale(context);
    appTheme.fetchTheme();

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (_, __) => MaterialApp.router(
        scrollBehavior: MyCustomScrollBehavior(),
        routerConfig: GoRouterConfig.router,
        debugShowCheckedModeBanner: false,
        title: '"templete"',
        locale: Locale(appLan.appLang.name),
        theme: appTheme.appThemeMode?.copyWith(
            scaffoldBackgroundColor: ThemeClass.of(context).background),
        supportedLocales: Languages.values.map((e) => Locale(e.name)).toList(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultMaterialLocalizations.delegate
        ],
      ),
    );
  }
}

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<bool>(context);
    print("Connectivity Status: $isConnected");

    if (!isConnected) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 19.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 350.w,
                    height: 420.h,
                    child: Column(
                      children: [
                        SizedBox(
                            height: 300.h,
                            width: 220.w,
                            child: Image.asset(Assets.imagesLogout)),
                        Gap(10.h),
                        Text(
                            "No connection",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                fontFamily: "Poppins"
                            )
                        ),
                        Gap(50.h)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return child;
  }
}

    //   Directionality(
    //     textDirection: TextDirection.ltr,
    //   child: Stack(
    //     alignment: Alignment.topCenter,
    //     children: [
    //       child,
    //       if (!isConnected)
    //         Positioned(
    //           top: 0,
    //           left: 0,
    //           right: 0,
    //           child: Container(
    //             width: 50.r,
    //             height: 20.r,
    //             padding: const EdgeInsets.all(8),
    //             color: Colors.red,
    //             child: const Center(
    //               child: Text(
    //                 textAlign: TextAlign.right,
    //                 "No Internet Connection",
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 16,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //     ],
    //   ),
    // );
 // }
//}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
