import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
}
