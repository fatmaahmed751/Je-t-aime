import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Models/user_model.dart';
import '../../../Utilities/shared_preferences.dart';
import '../../../generated/assets.dart';

class PersonalDataController extends ControllerMVC {
  // singleton
  factory PersonalDataController() {
    _this ??= PersonalDataController._();
    return _this!;
  }

  static PersonalDataController? _this;

  PersonalDataController._();

  bool loading = false, autoValidate = false;
  late TextEditingController nameController, phoneController, addressController,
      emailController;


  @override
  void initState() {
    //controller = CustomPopupMenuController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

init(){

        }
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

