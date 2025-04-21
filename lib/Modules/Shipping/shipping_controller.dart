import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Models/shipping_product_model.dart";
import "package:je_t_aime/Modules/Payment/payment_screen.dart";
import "package:je_t_aime/Modules/Shipping/shipping_data_handler.dart";
import 'package:je_t_aime/Modules/Shipping/widget/use_point_widget.dart';
import "package:je_t_aime/Utilities/router_config.dart";
import "package:je_t_aime/Utilities/shared_preferences.dart";
import "package:je_t_aime/core/Language/locales.dart";
import 'package:mvc_pattern/mvc_pattern.dart';

import "../../Models/cart_item_model.dart";
import "../../Models/shipping_model.dart";
import "../../Utilities/strings.dart";
import "../../Utilities/theme_helper.dart";
import "../../Widgets/toast_helper.dart";
import "../../generated/assets.dart";
import "../Cart/cart_data_handler.dart";

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
  static const pageSize = 10;
  List<CartModel> cart = [];
  ShippingModel? shippingModel;

  @override
  void initState() {
    // nameController = TextEditingController();
    // addressController = TextEditingController();
    // phoneController = TextEditingController();
    nameController = TextEditingController(text:"${shippingModel?.name}"??"");
    addressController = TextEditingController(text:"${shippingModel?.address}"??"");
    phoneController = TextEditingController(text:"${shippingModel?.phone}"??"");
    super.initState();
  }

  init(BuildContext context) {
    // getShippingData(context);
    getShippingData(context).then((_) {
      if (shippingModel != null) {
        nameController.text = shippingModel!.name ?? "";
        addressController.text = shippingModel!.address ?? "";
        phoneController.text = shippingModel!.phone ?? "";
      }
    });
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

  double calculateSubtotal(List<CartModel> cartProducts) {
    double subtotal = 0.0;

    for (var product in cartProducts) {
      subtotal += (product.price ?? 0) * (product.count ?? 1);
    }

    return subtotal;
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

  getShippingData(BuildContext context) async {
    setState(() {
      loading = true;
    });
    final result = await ShippingDataHandler.getDetailsOfShipping();

    result.fold((l) {
      // Handle error
      ToastHelper.showError(message: l.toString());
    }, (r) async {
      shippingModel = r;
      setState(() {
        nameController.text = shippingModel!.name ?? "";
        addressController.text = shippingModel!.address ?? "";
        phoneController.text = shippingModel!.phone ?? "";
      });
      ToastHelper.showSuccess(
        context: context,
        message: "shipping",
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor: ThemeClass.of(context).primaryColor,
      );
    });
    setState(() {
      loading = false;
    });
  }

  finishShipping({required BuildContext context}) async {
    setState(() {
      loading = true;
    });
    cart = await SharedPref.getCart();
    double totalPrice = calculateSubtotal(cart);
    final result = await ShippingDataHandler.shippingForOrder(
        items: cart,
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
        totalPrice: totalPrice);
    result.fold((l) {
      // Handle error
      ToastHelper.showError(message: l.toString());
    }, (r) async {
      ToastHelper.showSuccess(
        context: context,
        message: "shipping",
        icon: SvgPicture.asset(
          Assets.imagesSubmit,
          width: 60.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
        backgroundColor: ThemeClass.of(context).primaryColor,
      );
    });
    setState(() {
      loading = false;
    });
    context.pushNamed(
      PaymentScreen.routeName,
      // extra: shippingProductModel??ShippingProductModel()
    );
    // }
  }
}
