import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Models/user_model.dart';
import '../../Utilities/router_config.dart';
import '../../Utilities/shared_preferences.dart';
import '../../Utilities/strings.dart';
import 'alert_delete_item_widget.dart';

class CartController extends ControllerMVC {
  // singleton
  factory CartController() {
    _this ??= CartController._();
    return _this!;
  }
  // int counter = 1;
  //List<BannerModel>? fromShared;
  bool loading = false;

  double subtotal = 0;
  String token = '';
  bool isLike = true;

  late TextEditingController couponController;

  static CartController? _this;

  CartController._();
  int counterValue = 1;

  @override
  void initState() {
    couponController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  Future deleteItemFromCart(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) => AlertDeleteItemWidget(
        des: Strings.confirmDeleteItem.tr,
        mainText: Strings.deleteItem.tr,
        onButtonReject: currentContext_!.pop,
        onButtonAccept: currentContext_!.pop,
      ),
    );
  }

  void incrementCounter({required int counter}) {
    setState(() {
      counterValue++;
    });
    print("counter add ${counterValue}");
  }

  onFilledPersonalData() async {
    setState(() {
      loading = true;
    });
    UserModel? currentUser = SharedPref.getCurrentUser();

    await SharedPref.saveCurrentUser(user: currentUser!);
    // showDialog(
    //   context: currentContext_!,
    //   builder: (context) => const ConfirmDataSaved(),
    // );
    print('Updated UserModel: $currentUser');
    //  await Future.delayed(const Duration(seconds: 1));
    // currentContext_!.pushNamed(HomeScreen.routeName);
    // if (currentUser != null && nameController.text.isNotEmpty) {
    //   currentContext_!.pushNamed(
    //     UserProfileScreen.routeName,
    //   );
    // } else {
    //   print("Error: currentUser is null");
    // }

    setState(() {
      loading = false;
    });
  }

  void decrementCounter({required int counter}) {
    setState(() {
      if (counter > 1) {
        counterValue--;
      }
    });
  }

  onRemoveWarning(BuildContext ctx) {}
  init() {
    subtotal = 0;
  }
}
