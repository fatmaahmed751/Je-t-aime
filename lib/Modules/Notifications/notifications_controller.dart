// import "package:go_router/go_router.dart";
// import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
// import "package:je_t_aime/Modules/Notifications/notifications_data_handler.dart";
// import "package:je_t_aime/Modules/Orders/orders_data_handler.dart";
// import "package:je_t_aime/Modules/ShowOrderDetails/show_order_data_handler.dart";
// import 'package:mvc_pattern/mvc_pattern.dart';
//
// import "../../Models/notification_model.dart";
// import "../../Models/order_model.dart";
// import "../../Utilities/router_config.dart";
// import "../../Utilities/shared_preferences.dart";
// import "../../Widgets/toast_helper.dart";
// import "../ShowOrderDetails/show_order_screen.dart";
//
// class NotificationsController extends ControllerMVC {
//   // singleton
//   factory NotificationsController() {
//     _this ??= NotificationsController._();
//     return _this!;
//   }
//
//   static NotificationsController? _this;
//
//   NotificationsController._();
//
//   bool loading = false,
//       autoValidate = false;
//   bool isLogin = true;
//   List<OrderModel> orders=[];
//   static const pageSize = 10;
//   OrderModel? orderModel;
//
//
//   PagingController<int, NotificationModel>? _pagingController;
//
//   PagingController<int, NotificationModel> get pagingController {
//     // Ensure the controller is always initialized
//     _pagingController ??= PagingController(firstPageKey: 0);
//     return _pagingController!;
//   }
//
//   List<NotificationModel> notifications = [];
//
//   @override
//   void initState() {
//     super.initState();
//    // showOrderDetails(orderInfoId: orderModel?.id??0);
//     _initPagingController();
//   }
//
//   void init(PagingController<int, NotificationModel> pagingController) {
//     //  loadCart();
//     _pagingController = pagingController;
//     _pagingController!.addPageRequestListener((pageKey) {
//       getAllNotificationsList(pageKey);
//     });
//   }
//
//   void _initPagingController() {
//     _pagingController = PagingController(firstPageKey: 0);
//     _pagingController!.addPageRequestListener((pageKey) {
//       getAllNotificationsList(pageKey);
//     });
//     getAllNotificationsList(_pagingController!.firstPageKey);
//   }
//
//
//   allReadNotifications({required String notificationId,required int orderId}) async {
//     setState(() {
//       loading = true;
//     });
//     final result = await NotificationsDataHandler.readNotification(notificationId:notificationId );
//     result.fold((l) {
//       ToastHelper.showError(message: l.errorModel.statusMessage);
//     }, (r) async {
//       await showOrderDetails(orderInfoId:orderId );
//     });
//     setState((){
//       loading=false;
//     });
//   }
//
//
//
//   Future showOrderDetails({required int orderInfoId}) async {
//     print("1. Starting to fetch order details for ID: $orderInfoId");
//     loading = true;
//     setState(() {});
//
//     final result = await ShowOrderDataHandler.showOrderDetails(
//         orderId: orderInfoId
//       //  orderInfoId
//     );
//     print("2. Received API response");
//     result.fold((l) {
//       print("order errroooor${l.errorModel.statusMessage}");
//       ToastHelper.showError(message: l.toString());
//     }, (r) {
//       if (r.id != null) {
//         orderModel = r;
//         print("*******************************$orderModel");
//         print("Fetched orderModel: ${orderModel?.toJson()}");
//         currentContext_!.pushNamed(
//             ShowOrderWidget.routeName,extra:orderModel);
//       } else {
//         ToastHelper.showError(message: "Failed to fetch order info");
//       }
//     });
//
//     setState(() {
//       loading = false;
//     });
//   }
//
//   Future<void> getAllNotificationsList(int pageKey) async {
//     if (loading) return; // Avoid duplicate calls
//     loading = true;
//     notifyListeners();
//
//     final newItems = await NotificationsDataHandler.listOfAllNotifications(
//         pageKey, pageSize);
//
//     newItems.fold(
//           (failure) {
//         _pagingController!.error = failure;
//       },
//           (notifications) {
//         final isLastPage = notifications.length < pageSize;
//         if (isLastPage) {
//           _pagingController!.appendLastPage(notifications);
//         } else {
//           final nextPageKey = pageKey + notifications.length;
//           _pagingController!.appendPage(notifications, nextPageKey);
//         }
//
//         // Update the local notifications list
//         this.notifications = _pagingController!.itemList ?? [];
//         //  SharedPref.saveCart(this.notifications); // Save to SharedPreferences
//
//         loading = false;
//         notifyListeners();
//       },
//     );
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
// }
import "package:go_router/go_router.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:je_t_aime/Modules/Notifications/notifications_data_handler.dart";
import "package:je_t_aime/Modules/Orders/orders_data_handler.dart";
import "package:je_t_aime/Modules/ShowOrderDetails/show_order_data_handler.dart";
import 'package:mvc_pattern/mvc_pattern.dart';

import "../../Models/notification_model.dart";
import "../../Models/order_model.dart";
import "../../Utilities/router_config.dart";
import "../../Utilities/shared_preferences.dart";
import "../../Widgets/toast_helper.dart";
import "../ShowOrderDetails/show_order_screen.dart";

class NotificationsController extends ControllerMVC {
  // singleton
  factory NotificationsController() {
    _this ??= NotificationsController._();
    return _this!;
  }

  static NotificationsController? _this;

  NotificationsController._();

  bool loading = false, autoValidate = false;
  bool isLogin = true;
  OrderModel? orderModel;

  // Notification pagination
  static const notificationPageSize = 10;
   PagingController<int, NotificationModel>? notificationPagingController =
  PagingController(firstPageKey: 0);
  List<NotificationModel> notifications = [];
  PagingController<int, NotificationModel> get pagingController {
    // Ensure the controller is always initialized
    notificationPagingController ??= PagingController(firstPageKey: 0);
    return notificationPagingController!;
  }
  // Order pagination (for accessing order info)
  static const orderPageSize = 10;
   PagingController<int, OrderModel>? orderPagingController =
  PagingController(firstPageKey: 0);
  PagingController<int, OrderModel> get pagingOrderController {
    // Ensure the controller is always initialized
    orderPagingController ??= PagingController(firstPageKey:0);
    return orderPagingController!;
  }
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    notificationPagingController = PagingController(firstPageKey: 0);
    orderPagingController = PagingController(firstPageKey: 0);
    _initPagingControllers();
  }

  void init(PagingController<int, NotificationModel> pagingController,PagingController<int, OrderModel> ordersController) {
    //  loadCart();
    notificationPagingController = pagingController;
    // notificationPagingController!.addPageRequestListener((pageKey) {
    //   getAllNotificationsList(pageKey);
    // });
    orderPagingController= ordersController;
    //flow two
    _initPagingControllers();
    // orderPagingController!.addPageRequestListener((pageKey) {
    //   getOrdersList(pageKey);
    // });
  }

  void _initPagingControllers() {
    // Initialize notifications pagination
    notificationPagingController!.addPageRequestListener((pageKey) {
      getAllNotificationsList(pageKey);
    });

    // Initialize orders pagination
    orderPagingController!.addPageRequestListener((pageKey) {
      getOrdersList(pageKey);
    });

    // Load initial data
    getAllNotificationsList(notificationPagingController!.firstPageKey);
    getOrdersList(orderPagingController!.firstPageKey);
  }

  Future<void> getAllNotificationsList(int pageKey) async {
    if (loading) return;
    loading = true;
    notifyListeners();

    final newItems = await NotificationsDataHandler.listOfAllNotifications(
        pageKey, notificationPageSize);

    newItems.fold(
          (failure) {
        notificationPagingController!.error = failure;
        loading = false;
        notifyListeners();
      },
          (newNotifications) {
        final isLastPage = newNotifications.length < notificationPageSize;
        if (isLastPage) {
          notificationPagingController!.appendLastPage(newNotifications);
        } else {
          final nextPageKey = pageKey + newNotifications.length;
          notificationPagingController!.appendPage(newNotifications, nextPageKey);
        }

        notifications = notificationPagingController!.itemList ?? [];
        loading = false;
        notifyListeners();
      },
    );
  }

  Future<void> getOrdersList(int pageKey) async {
    if (loading) return;
    loading = true;
    notifyListeners();

    final newItems = await OrdersDataHandler.listOfOrders(pageKey, orderPageSize);

    newItems.fold(
          (failure) {
        orderPagingController!.error = failure;
        loading = false;
        notifyListeners();
      },
          (newOrders) {
        final isLastPage = newOrders.length < orderPageSize;
        if (isLastPage) {
          orderPagingController!.appendLastPage(newOrders);
        } else {
          final nextPageKey = pageKey + newOrders.length;
          orderPagingController!.appendPage(newOrders, nextPageKey);
        }

        orders = orderPagingController!.itemList ?? [];
        loading = false;
        notifyListeners();
      },
    );
  }

  allReadNotifications({required String notificationId, required int orderId}) async {
    setState(() {
      loading = true;
    });
    final result = await NotificationsDataHandler.readNotification(notificationId: notificationId);
    result.fold((l) {
      ToastHelper.showError(message: l.errorModel.statusMessage);
    }, (r) async {
      await showOrderDetails(orderInfoId: orderId);
    });
    setState(() {
      loading = false;
    });
  }

  Future showOrderDetails({required int orderInfoId}) async {
    print("1. Starting to fetch order details for ID: $orderInfoId");
    loading = true;
    setState(() {});

    // First try to find the order in our local list
    final localOrder = orders.firstWhere(
          (order) => order.id == orderInfoId,
      orElse: () => OrderModel(),
    );

    if (localOrder.id != null) {
      orderModel = localOrder;
      currentContext_!.pushNamed(ShowOrderWidget.routeName, extra: orderModel);
      loading = false;
      setState(() {});
      return;
    }

    // If not found locally, fetch from API
    final result = await ShowOrderDataHandler.showOrderDetails(orderId: orderInfoId);
    print("2. Received API response");
    result.fold((l) {
      print("order errroooor${l.errorModel.statusMessage}");
      ToastHelper.showError(message: l.toString());
    }, (r) {
      if (r.id != null) {
        orderModel = r;
        print("*******************************$orderModel");
        print("Fetched orderModel: ${orderModel?.toJson()}");
        currentContext_!.pushNamed(ShowOrderWidget.routeName, extra: orderModel);
      } else {
        ToastHelper.showError(message: "Failed to fetch order info");
      }
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    notificationPagingController!.dispose();
    orderPagingController!.dispose();
    super.dispose();
  }
}