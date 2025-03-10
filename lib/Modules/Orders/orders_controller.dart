import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Modules/Orders/orders_data_handler.dart";
import 'package:mvc_pattern/mvc_pattern.dart';

import "../../Models/order_model.dart";
import "../../Utilities/shared_preferences.dart";
import "../../Widgets/toast_helper.dart";

class OrdersController extends ControllerMVC {
  // singleton
  factory OrdersController() {
    _this ??= OrdersController._();
    return _this!;
  }

  static OrdersController? _this;

  OrdersController._();

  bool loading = false;
  bool isLogin = false;
 List<OrderModel> orders=[];
  static const pageSize = 10;

  PagingController<int, OrderModel>? _pagingController;
  PagingController<int, OrderModel> get pagingController {
    // Ensure the controller is always initialized
    _pagingController ??= PagingController(firstPageKey:0);
    return _pagingController!;
  }
  @override
  void initState() {
    super.initState();
  _initPagingController();

  }

  void init(PagingController<int, OrderModel> pagingController) {
    _pagingController = pagingController;
    _pagingController!.addPageRequestListener((pageKey) {
      getOrdersList(pageKey);
    });
  }
  void _initPagingController() {
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController!.addPageRequestListener((pageKey) {
     getOrdersList(pageKey);
    });
   getOrdersList(_pagingController!.firstPageKey);
  }

  Future<void>getOrdersList(int pageKey) async {
    if (loading) return; // Avoid duplicate calls
    loading = true;
    notifyListeners();

    final newItems = await OrdersDataHandler.listOfOrders(pageKey, pageSize);

    newItems.fold(
          (failure) {
        _pagingController!.error = failure;
      },
          (orders) {
            print("Parsed Orders: ${orders.toString()}");
        final isLastPage = orders.length < pageSize;
            print("Parsed Orders: ${orders.length}");
        if (isLastPage) {
          _pagingController!.appendLastPage(orders);
        } else {
          final nextPageKey = pageKey + orders.length;
          _pagingController!.appendPage(orders, nextPageKey);
        }

        // Update the local orders list
        this.orders = orders;

        loading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


}
