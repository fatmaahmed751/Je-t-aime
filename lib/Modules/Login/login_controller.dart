import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../../Utilities/router_config.dart";
import "../../../Utilities/shared_preferences.dart";
import "../../Widgets/toast_helper.dart";
import "../Home/home_screen.dart";
import "login_data_handler.dart";

class LoginController extends ControllerMVC {
  // singleton
  factory LoginController() {
    _this ??= LoginController._();
    return _this!;
  }
  static LoginController? _this;
  LoginController._();
  bool loading = false, autoValidate = false;
  bool isPassword = true;
  late TextEditingController emailController, passwordController;
  // final GoogleSignIn googleSignIn = GoogleSignIn(
  //   scopes: ['email'],
  // );
  // final AuthService _authService = AuthService();
  // UserModel? userModel;
  // final AuthController _authController = AuthController();
  // GoogleSignInAccount? currentUser;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  onLogin() async {
    setState(() {
      loading = true;
    });
    final result = await LoginDataHandler.login(
      email: emailController.text,
      password: passwordController.text,
    );

    result.fold((l) {
      ToastHelper.showError(message: l.errorModel.statusMessage);
    }, (r) async {
      // await SharedPref.saveCurrentUser(user: r);
      print("token loginnnn ${SharedPref.getCurrentUser()?.token}");
      currentContext_?.pushNamed(
        HomeScreen.routeName,
      );
      setState(() {});
    });
    setState(() {
      loading = false;
    });
  }
}
