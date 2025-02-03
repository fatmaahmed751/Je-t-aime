import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/ResetPassword/reset_passwod_data_handler.dart';
import 'package:je_t_aime/Modules/ResetPassword/reset_password_screen.dart';
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
import '../Login/login_screen.dart';
import '../VerificationAccountOtp/verification_otp_data_handler.dart';
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
  int? userId;
  bool isPassword = true;
  bool repeatPassword = true;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    pinController = TextEditingController();
    focusNode = FocusNode();
    smsRetriever = SmsRetrieverImpl(SmartAuth.instance);
    userId = SharedPref.getCurrentUser()?.user?.id;
    String? email;
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

  resendVerifyAccountCode() async {
    if (userId == null) {
      userId = SharedPref.getCurrentUser()
          ?.user
          ?.id; // Attempt to fetch from SharedPref
      if (userId == null) {
        print('User ID is missing');
        ToastHelper.showError(message: "User ID is required for verification.");
        return;
      }
    }
    // if (pinController.text.isEmpty) {
    //   ToastHelper.showError(message: "Please enter the OTP code.");
    //   return;
    // }
    setState(() {
      loading = true;
    });
    final result = await OTPCodeDataHandler.resentOtp(
      id: userId!,
    );
    print(result);
    result.fold((l) {
      print('Failure: ${l.toString()}');
      ToastHelper.showError(
          message: Strings.verificationFailed.tr,
          backgroundColor: ThemeClass.of(currentContext_!).primaryColor);
    }, (r) {
      ToastHelper.showSuccess(
        context: currentContext_!,
        message: Strings.verificationSuccess.tr,
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor: ThemeClass.of(currentContext_!).primaryColor,
      );
    });
    setState(() {
      loading = false;
    });
  }

  verifyCodeForNewPassword() async {
    setState(() {
      loading = true;
    });
    final loggedInUserId = SharedPref.getCurrentUser()?.user?.id;

    // Verify the userId matches the logged-in user's ID
    if (userId == null || loggedInUserId != userId) {
      print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm.");
      ToastHelper.showError(message: "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv.");
      return;
    }

    if (email == null) {
      print("Error: email or code is null");
      ToastHelper.showError(message: "Email or code is missing.");
      return;
    }
    if (pinController.text.isEmpty) {
      ToastHelper.showError(message: "The code is not correct.");
      return;
    }
    setState(() {
      loading = true;
    });
    final result = await ResetPasswordDataHandler.verificationCodeResetPassword(
        email: email!);
    result.fold((l) {
      ToastHelper.showError(message: l.errorModel.statusMessage.toString());
      ToastHelper.showError(message: "the email is incorrect.");
    }, (r) {
      print(r);
      ToastHelper.showSuccess(
        context: currentContext_!,
        message: Strings.passwordResetSu.tr,
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor: ThemeClass.of(currentContext_!).primaryColor,
      );
      currentContext_?.pushNamed(ResetPasswordScreen.routeName,
          extra: loggedInUserId.toString());
    });
    setState(() {
      loading = false;
    });
  }

  getNewPassword() async {
    setState(() {
      loading = true;
    });
    print("PIN Value: ${pinController.text}");

    // Check if the PIN is empty
    if (pinController.text.isEmpty) {
      print("Error: PIN is empty.");
      ToastHelper.showError(message: "Please enter your PIN.");
      setState(() {
        loading = false;
      });
      return;
    }
    final loggedInUserId = SharedPref.getCurrentUser()?.user?.id;
    print("Logged In User ID: $loggedInUserId");
    print("User ID: $userId");

    if (userId == null || loggedInUserId != userId) {
      print("Error: User ID is null or does not match logged-in user ID.");
      ToastHelper.showError(message: "Invalid user ID.");
      return;
    }

    if (pinController.text.isEmpty) {
      print("Error: PIN is empty.");
      ToastHelper.showError(message: "Please enter your PIN.");
      return;
    }

    if (newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      ToastHelper.showError(message: "Please fill in both password fields.");
      return;
    }

    final result = await ResetPasswordDataHandler.resetNewPassword(
      id: userId!,
      password: newPasswordController.text,
      confirmPassword: confirmNewPasswordController.text,
    );

    result.fold((l) {
      ToastHelper.showError(message: l.errorModel.statusMessage.toString());
    }, (r) {
      ToastHelper.showSuccess(
        context: currentContext_!,
        message: Strings.passwordResetSu.tr,
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor: ThemeClass.of(currentContext_!).primaryColor,
      );
      currentContext_?.pushNamed(LoginScreen.routeName);
    });

    setState(() {
      loading = false;
    });
  }
  // getNewPassword() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   final loggedInUserId = SharedPref.getCurrentUser()?.user?.id;
  //   if (userId == null || loggedInUserId != userId) {
  //     print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk.");
  //     ToastHelper.showError(message: "llllllllllllllllll.");
  //     return;
  //   }
  //   if (userId == null || pinController.text.isEmpty) {
  //     print("Error: cccccccccccccccccccccccccccccccccc");
  //     ToastHelper.showError(message: "ooooooooooooooo.");
  //     return;
  //
  //   }
  //   print("Logged In User ID: $loggedInUserId");
  //   print("User ID: $userId");
  //   if (newPasswordController.text.isEmpty ||
  //       confirmNewPasswordController.text.isEmpty) {
  //     ToastHelper.showError(message: "Please fill in both password fields.");
  //     return;
  //   }
  //
  //   final result = await ResetPasswordDataHandler.resetNewPassword(
  //     id: userId!,
  //     password: newPasswordController.text,
  //     confirmPassword: confirmNewPasswordController.text,
  //   );
  //   result.fold((l) {
  //     ToastHelper.showError(message: l.errorModel.statusMessage.toString());
  //     ToastHelper.showError(message: "password fields.");
  //   }, (r) {
  //     print(r);
  //     ToastHelper.showSuccess(
  //       context:   currentContext_!,
  //       message: Strings.passwordResetSu.tr,
  //       icon:SvgPicture.asset(Assets.imagesSubmit,width:60.w,
  //         height:50.h,
  //         fit: BoxFit.cover,),
  //
  //       backgroundColor: ThemeClass.of(currentContext_!).primaryColor,
  //     );
  //     currentContext_?.pushNamed(
  //       LoginScreen.routeName,
  //     );
  //   });
  //   setState(() {
  //     loading = false;
  //   });
  // }
}
