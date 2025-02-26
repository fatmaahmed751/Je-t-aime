import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Modules/Payment/payment_screen.dart";
import "package:je_t_aime/Modules/Shipping/shipping_data_handler.dart";
import 'package:je_t_aime/Modules/Shipping/widget/use_point_widget.dart';
import "package:je_t_aime/Utilities/router_config.dart";
import "package:je_t_aime/core/Language/locales.dart";
import 'package:mvc_pattern/mvc_pattern.dart';

import "../../Utilities/strings.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";

class ShippingController extends ControllerMVC {
  // singleton
  factory ShippingController() {
    _this ??= ShippingController._();
    return _this!;
  }

  static ShippingController? _this;

  ShippingController._();

  bool loading = false,
      autoValidate = false;
  late TextEditingController nameController, addressController, phoneController;
  static const pageSize = 10;

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

  // getDetailsOfShipping({required BuildContext context}) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   final result = await ShippingDataHandler.shippingForOrder(
  //       items: [],
  //       name: nameController.text,
  //       phone: phoneController.text,
  //       address:addressController.text,
  //       totalPrice: null);
  //   result.fold((l) {
  //     // Handle error
  //     ToastHelper.showError(message: l.toString());
  //   }, (r) async {
  //     ToastHelper.showSuccess(
  //       context: context,
  //       message: "sucesssssssssssssss",
  //       icon: SvgPicture.asset(
  //         Assets.imagesSubmit,
  //         width: 60.w,
  //         height: 50.h,
  //         fit: BoxFit.cover,
  //       ),
  //       backgroundColor:
  //       ThemeClass.of(context).primaryColor,
  //     );
  //
  //   });
  //   setState(() {
  //     loading = false;
  //   });
  // }
}
