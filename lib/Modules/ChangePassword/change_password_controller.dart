import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Utilities/router_config.dart';
import '../PersonalData/personal_data_screen.dart';
import 'change_password_data_handler.dart';

class ChangePasswordController extends ControllerMVC {
  // singleton
  factory ChangePasswordController() {
    _this ??= ChangePasswordController._();
    return _this!;
  }
  static ChangePasswordController? _this;
  ChangePasswordController._();
  bool loading=false,autoValidate = false;
  late TextEditingController newPasswordController;
  late TextEditingController oldPasswordController;
  late TextEditingController confirmNewPasswordController;
  bool isPassword = true;
  bool newPassword = true;
  bool repeatPassword = true;
  @override
  void initState() {
    newPasswordController=TextEditingController();
    oldPasswordController=TextEditingController();
    confirmNewPasswordController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    newPasswordController.dispose();
    oldPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

}
