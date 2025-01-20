import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/ResetPassword/reset_passwod_data_handler.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';
import '../../Utilities/router_config.dart';
import '../../Utilities/shared_preferences.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/toast_helper.dart';
import '../../generated/assets.dart';
import '../Home/home_screen.dart';
import '../VerificationAccountOtp/verification_otp_screen.dart';

class ResetPasswordController extends ControllerMVC {
  // singleton
  factory ResetPasswordController() {
    _this ??= ResetPasswordController._();
    return _this!;
  }
  static ResetPasswordController? _this;
  ResetPasswordController._();
  bool loading = false, autoValidate = false;
  late TextEditingController newPasswordController,
      confirmNewPasswordController;
  late SmsRetriever smsRetriever;
  late TextEditingController pinController;
  late FocusNode focusNode;
  String? email;
  int? userId ;
  bool isPassword = true;
  bool repeatPassword = true;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    pinController = TextEditingController();
    focusNode = FocusNode();
    smsRetriever = SmsRetrieverImpl(SmartAuth());
    final userId = SharedPref.getCurrentUser()?.user?.id;
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }


  void verifyCode(String code, String inputCode) {
    if (code == inputCode) {
      print('Verification successful');
    } else {
      print('Verification failed');
    }
  }
  getNewPassword() async {
    setState(() {
      loading = true;
    });
    if (userId == null || pinController.text.isEmpty) {
      print("Error: email or code is null");
      ToastHelper.showError(message: "Email or code is missing.");
      return;
    }
    if (newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      ToastHelper.showError(message: "Please fill in both password fields.");
      return;
    }
    setState(() {
      loading = true;
    });

    final result = await ResetPasswordDataHandler.resetNewPassword(
      id: userId!,
      password: newPasswordController.text,
      confirmPassword: confirmNewPasswordController.text,
    );
    result.fold((l) {
      ToastHelper.showError(message: l.errorModel.statusMessage.toString());
      ToastHelper.showError(message: "password fields.");
    }, (r) {
      print(r);
      ToastHelper.showSuccess(
        context:   currentContext_!,
        message: Strings.passwordResetSu.tr,
        icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
          height:50.h,
          fit: BoxFit.cover,),

        backgroundColor: ThemeClass.of(currentContext_!).primaryColor,
      );
      currentContext_?.pushNamed(
        HomeScreen.routeName,
      );
    });
    setState(() {
      loading = false;
    });
  }
}
