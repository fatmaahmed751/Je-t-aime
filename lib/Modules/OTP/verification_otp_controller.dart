
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

import 'verification_otp_screen.dart';

class VerificationOtpController extends ControllerMVC {
  // singleton
  factory VerificationOtpController() {
    _this ??= VerificationOtpController._();
    return _this!;
  }
  static VerificationOtpController? _this;
  VerificationOtpController._();
  bool loading=false,autoValidate = false;
 late final SmsRetriever smsRetriever;
  late TextEditingController pinController;
  late final FocusNode focusNode;
  String? email;
  @override
  void initState() {
    super.initState();
    pinController= TextEditingController();
    focusNode = FocusNode();
   smsRetriever = SmsRetrieverImpl(
        SmartAuth());

  }
  @override
  void dispose() {
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





}







