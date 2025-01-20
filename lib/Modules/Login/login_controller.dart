import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../Models/user_model.dart';
import '../../../Utilities/api_end_point.dart';
import '../../../Utilities/router_config.dart';
import '../../../Utilities/shared_preferences.dart';
import '../../Widgets/toast_helper.dart';
import '../Home/home_screen.dart';
import 'login_data_handler.dart';

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
 //  emailController = TextEditingController(text:"sohum1@bcampbelleo.com");
 //  passwordController = TextEditingController(text:"Amirafatma@202020");
   // emailController = TextEditingController(text:"gwendola@laoraclej.com");
   //  passwordController = TextEditingController(text:"Amirafatma@202020");
    super.initState();
    // googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   setState(() {
    //     currentUser = account;
    //   });
    // });
    // googleSignIn.signInSilently();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Future<UserModel?> signIn() async {
  //   return await _authService.signInWithApple();
  // }
  //
  // void signOut() {
  //   _authService.signOut();
  // }
  //
  // void handleSignOut() {
  //   _authController.signOut();
  //   setState(() {
  //     userModel = null;
  //   });
  // }
  //
  // void handleSignInWithApple() async {
  //   final user = await _authController.signIn();
  //   setState(() {
  //     userModel = user;
  //   });
  // }
  //
  // Future<void> handleSignIn() async {
  //   try {
  //     GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     if (googleUser != null) {
  //       GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //       String? idToken = googleAuth.idToken;
  //
  //       // Send this ID token to your private API for verification
  //       print("IDbbbbbbbbbbbbbbbbbbb Token: $idToken");
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  //
  // Future<void> sendTokenToAPI(String? idToken) async {
  //   if (idToken == null) return;
  //   final response = await http.post(
  //     Uri.parse(APIEndPoint.login),
  //     body: jsonEncode({
  //       'token': idToken, // Send the ID token to your backend API
  //     }),
  //     headers: {'Content-Type': 'multipart/form-data'},
  //   );
  //   // var response = await GenericRequest<String>(
  //   //   method: RequestApi.postJson(
  //   //     url: APIEndPoint.login,
  //   //     bodyJson: ({
  //   //       'token': idToken,
  //   //     }),
  //   //   ),
  //   //   fromMap: (_) => _["data"]['key'],
  //   // ).getResponse();
  //   if (response.statusCode == 200) {
  //     // Successful login
  //     print('Login successful');
  //   } else {
  //     // Handle error
  //     print('Login failed');
  //   }
  // }
  //
  // signInWithApple() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   await Future.delayed(const Duration(seconds: 2));
  //   setState(() {
  //     loading = false;
  //   });
  // }
  //
  // Future<void> handleGoogleSignOut() async {
  //   googleSignIn.disconnect();
  // }
  //
  // signInWithGoogle() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   await Future.delayed(const Duration(seconds: 2));
  //   setState(() {
  //     loading = false;
  //   });
  // }
  //
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
