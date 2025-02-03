import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:je_t_aime/Modules/Shipping/widget/use_point_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ShippingController extends ControllerMVC {
  // singleton
  factory ShippingController() {
    _this ??= ShippingController._();
    return _this!;
  }
  static ShippingController? _this;
  ShippingController._();
  bool loading = false, autoValidate = false;
  late TextEditingController nameController, addressController, phoneController;

  @override
  void initState() {
    nameController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  reset() {
    nameController.clear();
    addressController.clear();
    phoneController.clear();
  }

  usePointsAlert(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => const UsePointWidget());
  }
}
