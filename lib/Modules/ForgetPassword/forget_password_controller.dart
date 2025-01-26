import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Utilities/router_config.dart';
import '../../Widgets/toast_helper.dart';
import '../ResetPassword/reset_passwod_data_handler.dart';
import '../ResetPassword/widget/verify_password_otp.dart';

class ForgetPasswordController extends ControllerMVC {
  // singleton
  factory ForgetPasswordController() {
    _this ??= ForgetPasswordController._();
    return _this!;
  }
  static ForgetPasswordController? _this;
  ForgetPasswordController._();
  bool loading=false,autoValidate = false;
  late TextEditingController emailController;

  @override
  void initState() {
    emailController=TextEditingController();

    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  verifyCodeForNewPassword() async {
    setState(() {
      loading = true;
    });
    if (emailController.text.isEmpty) {
      print("Error: email or code is null");
      ToastHelper.showError(message: "Email or code is missing.");
      return;
    }
    final result = await ResetPasswordDataHandler.verificationCodeResetPassword(
        email:emailController.text

    );
    result.fold((l) {
      ToastHelper.showError(message: l.errorModel.statusMessage.toString());
      ToastHelper.showError(message: "email not correct");
    }, (r) {
      print(r);
      // ToastHelper.showSuccess(
      //   context:   currentContext_!,
      //   message: Strings.verifyCode.tr,
      //   icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
      //     height:50.h,
      //     fit: BoxFit.cover,),
      //   backgroundColor: ThemeClass.of(currentContext_!).primaryColor,
      // );
      currentContext_!.pushNamed(
          VerificationPasswordScreen.routeName,
          extra:emailController.text
      );
    });
    setState(() {
      loading = false;
    });
  }
  
}
