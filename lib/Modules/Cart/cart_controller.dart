import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Models/user_model.dart';
import '../../Utilities/dialog_helper.dart';
import '../../Utilities/shared_preferences.dart';
import '../../Utilities/strings.dart';

class CartController extends ControllerMVC {
  // singleton
  factory CartController() {
    _this ??= CartController._();
    return _this!;
  }
  // int counter = 1;
  //List<BannerModel>? fromShared;
  bool loading=false;

  double subtotal=0;
  String token='';
bool isLike = true;

 late TextEditingController couponController;

  static CartController? _this;

  CartController._();


  @override
  void initState() {
    couponController=TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  void incrementCounter({required int counter}) {
    setState(() {
      counter++;
    });
    print("counter add ${counter}");
  }
  onFilledPersonalData() async {
    setState(() {
      loading = true;
    });
    UserModel? currentUser = SharedPref.getCurrentUser();

      await SharedPref.saveCurrentUser(user:currentUser!);
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
        counter--;
      }
    });
  }
  onRemoveWarning(BuildContext ctx){


  }
  init(){
    subtotal=0;

  }


}