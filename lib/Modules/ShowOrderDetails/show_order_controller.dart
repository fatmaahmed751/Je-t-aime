import "package:go_router/go_router.dart";
import "package:je_t_aime/Modules/ShowOrderDetails/show_order_data_handler.dart";
import "package:je_t_aime/Modules/ShowOrderDetails/show_order_screen.dart";
import "package:mvc_pattern/mvc_pattern.dart";

import "../../Models/order_model.dart";
import "../../Utilities/router_config.dart";
import "../../Widgets/toast_helper.dart";

class ShowOrderController extends ControllerMVC {
  // singleton
  factory ShowOrderController() {
    _this ??= ShowOrderController._();
    return _this!;
  }

  static ShowOrderController? _this;

  ShowOrderController._();

  bool loading = false,
      autoValidate = false;
  bool isLogin = true;

  OrderModel? orderModel;


  @override
  void initState() {
    super.initState();
    // showOrderDetails(orderInfoId: orderModel?.id??0);

  }
  init(OrderModel? orderModel) {
    showOrderDetails(orderInfoId: orderModel?.id??0);
    if (orderModel?.id != null) {
      showOrderDetails(orderInfoId: orderModel!.id!);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future showOrderDetails({required int orderInfoId}) async {
    print("1. Starting to fetch order details for ID: $orderInfoId");
    loading = true;
    setState(() {});

    final result = await ShowOrderDataHandler.showOrderDetails(
        orderId: orderInfoId
      //  orderInfoId
    );
    print("2. Received API response");
    result.fold((l) {
      print("order errroooor${l.errorModel.statusMessage}");
      ToastHelper.showError(message: l.toString());
    }, (r) {
      // if (r.id != null) {
        orderModel = r;
        print("*******************************$orderModel");
        print("Fetched orderModel: ${orderModel?.toJson()}");
        // currentContext_!.pushNamed(
        //     ShowOrderWidget.routeName, extra: orderModel);
      // } else {
      //   ToastHelper.showError(message: "Failed to fetch order info");
      // }
    });

    setState(() {
      loading = false;
    });
  }
}