import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';



class PaymentController extends ControllerMVC {
// singleton
  factory PaymentController() {
    _this ??= PaymentController._();
    return _this!;
  }

  static PaymentController? _this;

  PaymentController._();

  bool loading = false,autoValidate = false;

  int selectedMethod = 0;

  @override
  void initState() {
    super.initState();
  }

  void selectPaymentMethod(int method) {
    if (selectedMethod == method) {
      selectedMethod = 0; // Deselect if already selected
    } else {
      selectedMethod = method; // Select the chosen method
    }
    setState(() {}); // Trigger the UI to update
  }

  init() {

  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPaymentSuccess(BuildContext ctx) async {

  }

}
