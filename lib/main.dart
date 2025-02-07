import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:flutter_svg/svg.dart";
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'Utilities/git_it.dart';
import 'Utilities/router_config.dart';
import 'Utilities/strings.dart';
import "Utilities/text_style_helper.dart";
import 'Utilities/theme_helper.dart';
import 'Widgets/check_internet_connection.dart';
import "Widgets/container_empty_content_widget.dart";
import "Widgets/custom_button_widget.dart";
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

  runApp(
    MultiProvider(
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
        title: "jetaime",
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
          body:
          Padding(
          padding: EdgeInsetsDirectional.only(
          start: 20.w,
            end: 20.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(190.h),
              SizedBox(
                height: 250.h,
                width: double.infinity,
                child: SvgPicture.asset(
                 Assets.imagesNoInternet
                 // fit: BoxFit.cover,
                ),
              ),
              Text(
                Strings.noInternet.tr,
                textAlign: TextAlign.center,
                style: TextStyleHelper.of(context)
                    .h_20
                    .copyWith(color: ThemeClass.of(context).mainBlack),
              ),
              Gap(20.h),
              SizedBox(
                //width: 382.w,
                // height: 85.h,
                child: Text(
                  Strings.checkNet.tr,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.of(context).b_16.copyWith(
                      color: ThemeClass.of(context).secondaryBlackColor),
                ),
              ),
              Gap(30.h),
              CustomButtonWidget.primary(
                  height: 48.h,
                  width: 155.w,
                  radius: 30.r,
                  title:  Strings.reload.tr,
                  onTap: () {
                    // SharedPref.getCurrentUser()!
                    //     .token!
                    //     .isNotEmpty
                    //     ? GoRouter.of(context)
                    //     .pushNamed(PopularProductsScreen.routeName,)
                    //     : GoRouter.of(context).pushNamed(
                    //     RegisterScreen.routeName);
                  }),
              Gap(120.h)
          ]

        ),
      ),
    ),
      );
    }

    return child;
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
