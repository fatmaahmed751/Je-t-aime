import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
class ShippingController extends ControllerMVC {
  // singleton
  factory ShippingController() {
    _this ??= ShippingController._();
    return _this!;
  }
  static ShippingController? _this;
  ShippingController._();
  bool loading=false,autoValidate = false;
  late TextEditingController nameController,addressController,phoneController;

  @override
  void initState() {
    nameController=TextEditingController();
    addressController=TextEditingController();
    phoneController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  reset(){
    nameController.clear();
    addressController.clear();
    phoneController.clear();
  }
}
