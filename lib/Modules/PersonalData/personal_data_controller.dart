import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import "../../Models/user_model.dart";
import "../../Utilities/shared_preferences.dart";

class PersonalDataController extends ControllerMVC {
  // singleton
  factory PersonalDataController() {
    _this ??= PersonalDataController._();
    return _this!;
  }

  static PersonalDataController? _this;

  PersonalDataController._();

  bool loading = false, autoValidate = false;
  late TextEditingController nameController,
      phoneController,
      addressController,
      emailController;
  User? user;

  @override
  void initState() {
    //controller = CustomPopupMenuController();
    nameController = TextEditingController(text:"${SharedPref.getCurrentUser()?.user?.name}"??"");
    phoneController = TextEditingController(text:"${SharedPref.getCurrentUser()?.user?.phone}"??"");
    addressController = TextEditingController();
    emailController = TextEditingController(text:"${SharedPref.getCurrentUser()?.user?.email}"??"");
    super.initState();
  }

  init() {}
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    emailController.dispose();
    // controller.dispose();
    super.dispose();
  }
}
