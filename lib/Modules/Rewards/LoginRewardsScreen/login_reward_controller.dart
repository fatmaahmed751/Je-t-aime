import 'package:mvc_pattern/mvc_pattern.dart';

class LoginRewardsController extends ControllerMVC {
  // singleton
  factory LoginRewardsController() {
    _this ??= LoginRewardsController._();
    return _this!;
  }
  static LoginRewardsController? _this;
  LoginRewardsController._();
  bool loading = false, autoValidate = false;
  bool isClick = true;
  bool isSearch = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  userRewards() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loading = false;
    });
  }
}
