
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Login/login_screen.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import '../../../Utilities/strings.dart';
import '../../../core/Language/app_languages.dart';
import '../../Utilities/router_config.dart';
import '../../Widgets/alert_dialoge_widget.dart';
import '../../Widgets/custom_bottom_sheet_widget.dart';
import 'Widget/change_languages_widget.dart';
class UserProfileController extends ControllerMVC {
  // singleton
  factory UserProfileController() {
    _this ??= UserProfileController._();
    return _this!;
  }

  static UserProfileController? _this;

  UserProfileController._();

  // late  CustomPopupMenuController controller ;
 // final homeController = HomeController();

  bool loading = false, autoValidate = false;
  bool isEnglishSelected = true;
  bool status = false;
  bool isLogin=true;
  String? selectedValue=Strings.setLocation.tr;



  @override
  void initState() {
   // controller = CustomPopupMenuController();
    super.initState();

  }
 init()async{
  loadCurrentLanguage(currentContext_!);
  //updateNotifications(currentContext_!);
  // getCities();
  // getUserCityName().then((_) {
  //   setState(() {
  //     selectedValue = selectedValue??Strings.setLocation.tr;
  //   });
  // });
}
  @override
  void dispose() {
  //  controller.dispose();
    super.dispose();
  }
  // void updateNotifications(BuildContext context) async {
  //   final result = await NotificationsDataHandler.unReadNotification();
  //   result.fold((l) {
  //     ToastHelper.showError(message: l.errorModel.statusMessage);
  //   }, (r) {
  //     // Update the unread count in the provider
  //     Provider.of<NotificationProvider>(context, listen: false).updateUnreadCount(r.notificationsCount ?? 0);
  //   });
  // }

  onFilledPersonalData() async {
    setState(() {
      loading = true;
    });

    setState(() {
      loading = false;
    });
  }

  onLogin() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loading = false;
    });
  }

  int selectedLanguage = 1;

  void selectLanguage(int language) {
    selectedLanguage = language;
    setState(() {});
  }


  // deleteUserAccountPop(BuildContext ctx){
  //   DialogHelper.custom(context: ctx).customDialog(
  //       dialogWidget: AlertWarningWidget(
  //         des: Strings.confirmDeleteAccount.tr,
  //         onButtonAccept: () {
  //           deleteAccountSuccessfully();
  //           GoRouter.of(currentContext_!).pushNamed(RegisterScreen.routeName);
  //
  //           ctx.pop();
  //         },
  //         onButtonReject: () {
  //           ctx.pop();
  //         },
  //         titleButtonAccept: Strings.yes.tr,
  //         titleButtonReject: Strings.cancel.tr,
  //       ),
  //       dismiss: false);
  // }
  //
  userLogOutPop(BuildContext context){
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder:(context)=> AlertWarningWidget(
        des:Strings.confirmLogout.tr,
        secondButtonText: Strings.logOut.tr,
        mainText: Strings.deleteLogOutSide.tr,
        onButtonReject:
        currentContext_!.pop,
        onButtonAccept: (){
          GoRouter.of(context).pushNamed(LoginScreen.routeName);
        },
      ),
    );
  }

  // deleteAccountSuccessfully() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   final result = await UserProfileDataHandler.deleteUserAccount();
  //
  //   result.fold((l) {
  //     //ToastHelper.showError(message: l.errorModel.statusMessage);
  //   }, (r)async {
  //     SharedPref.logout();
  //     SharedPref.saveCurrentUser(user:UserModel());
  //     print("uer model${SharedPref.getCurrentUser()?.id}");
  //     final token = SharedPref.getCurrentUser()?.token;
  //     print("********************token: $token");
  //   });
  //   await Future.delayed(const Duration(seconds: 2));
  //   setState((){loading=false;});
  //
  // }
  //
  Future deleteUserAccountPop(BuildContext context) {
    return showModalBottomSheet(
      context: context,
   // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder:(context)=> AlertWarningWidget(
        secondButtonText: Strings.delete.tr,
       des:Strings.confirmDeleteAccount.tr,
        mainText: Strings.deleteAccountSide.tr,
        onButtonReject:
          currentContext_!.pop,
        onButtonAccept: (){
         GoRouter.of(context).pushNamed(LoginScreen.routeName);
        },
      ),
    );
  }
  changeLanguageOfApp(BuildContext context) async {
    await loadCurrentLanguage(context);
    showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => const ChangeLanguage());
  }
  Future<void> loadCurrentLanguage(BuildContext ctx) async {
    await Provider.of<AppLanguage>(ctx, listen: false).fetchLocale(ctx);

    final currentLanguage = Provider.of<AppLanguage>(ctx, listen: false).appLang;

    print("Current language: $currentLanguage");
    setState(() {
      selectedLanguage = currentLanguage == Languages.en ? 1 : 2;
    });
  }

  // Future<void> _handlePermissionGranted() async {
  //   final result = await HomeDataHandler.addDevice();
  //   result.fold(
  //           (l) => ToastHelper.showError(message: l.toString()),
  //           (r) {
  //         //ToastHelper.showSuccess(message: "doneee");
  //       }
  //   );
  // }


}