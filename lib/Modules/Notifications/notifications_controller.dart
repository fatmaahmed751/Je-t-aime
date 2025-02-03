import 'package:mvc_pattern/mvc_pattern.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
