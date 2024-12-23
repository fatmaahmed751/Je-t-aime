import 'package:mvc_pattern/mvc_pattern.dart';

class OrdersController extends ControllerMVC {
  // singleton
  factory OrdersController() {
    _this ??= OrdersController._();
    return _this!;
  }

  static OrdersController? _this;

  OrdersController._();

  bool loading = false;
 // List<OrderInfoModel> orders=[];


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
init(){
 // listOfOrders();
}


}