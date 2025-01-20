
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Modules/Register/register_data_handler.dart';
import 'package:je_t_aime/Utilities/shared_preferences.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Models/user_model.dart';
import '../../Utilities/router_config.dart';
import '../../Widgets/toast_helper.dart';
import '../VerificationAccountOtp/verification_otp_screen.dart';

class RegisterController extends ControllerMVC {
  // singleton
  factory RegisterController() {
    _this ??= RegisterController._();
    return _this!;
  }
  static RegisterController? _this;
  RegisterController._();
  bool loading=false,autoValidate = false;
  late TextEditingController emailController,
      passwordController,
      confirmPasswordController;
  // final GoogleSignIn googleSignIn = GoogleSignIn(
  //   scopes: ['email'],
  // );
  // final AuthService _authService = AuthService();
   UserModel? userModel;
   bool isPassword = true;
  bool isConfirmPassword = true;
  // final AuthController _authController = AuthController();
  // GoogleSignInAccount? currentUser;
  @override
  void initState() {
    emailController=TextEditingController();
    passwordController=TextEditingController(text:"Nonabatta@202020");
    confirmPasswordController=TextEditingController(text:"Nonabatta@202020");
    super.initState();
   //  googleSignIn.onCurrentUserChanged
   //      .listen((GoogleSignInAccount? account) {
   //    setState(() {
   //      currentUser = account;
   //    });
   //  });
   // googleSignIn.signInSilently();

  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Future<UserModel?> signIn() async {
  //   return await _authService.signInWithApple();
  // }
  // void signOut() {
  //   _authService.signOut();
  // }
  // void handleSignOut() {
  //   _authController.signOut();
  //   setState(() {
  //     userModel = null;
  //   });
  // }
  // void handleSignInWithApple() async {
  //   final user = await _authController.signIn();
  //   setState(() {
  //     userModel = user;
  //   });
  //
  //
  // }
  //
  // signInWithApple()async{
  //   setState((){loading=true;});
  //   await Future.delayed(const Duration(seconds: 2));
  //   setState((){loading=false;});
  // }
  // Future<void> handleSignInWithGoogle() async {
  //   try {
  //     final account = await googleSignIn.signIn();
  //     if (account != null) {
  //       final authentication = await account.authentication;
  //       final idToken = authentication.idToken;
  //       await _sendTokenToServer(idToken);
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  //
  // Future<void> _sendTokenToServer(String? idToken) async {
  //   if (idToken == null) return;
  //   //final url = Uri.parse(APIEndPoint.register);
  //
  //   try {
  //     // final response = await http.post(
  //     //   Uri.parse(APIEndPoint.register),
  //     //   body: jsonEncode({
  //     //     'token': idToken,
  //     //   }),
  //     //   headers: {'Content-Type': 'multipart/form-data'},
  //     // );
  //     final response = await GenericRequest<String>(
  //       method: RequestApi.postJson(
  //         url: APIEndPoint.register,
  //         bodyJson: ({
  //           'token': idToken,
  //         }),
  //         headers: {'Content-Type': 'multipart/form-data'},
  //       ),
  //       fromMap: (_) => _["data"]['key'],
  //     ).getResponse();
  //     if (response.isNotEmpty) {
  //       final data = json.decode(response);
  //       print('User authenticated successfully: ${data['message']}');
  //
  //     }  else {
  //       print('Failed to authenticate user: $response');
  //     }
  //   } catch (error) {
  //     print('Error during API request: $error');
  //   }
  //     }
  //
  //
  // Future<void> handleGoogleSignOut() async {
  //   googleSignIn.disconnect();
  // }
  //
  // signInWithGoogle()async{
  //   setState((){loading=true;});
  //   await Future.delayed(const Duration(seconds: 2));
  //   setState((){loading=false;});
  // }

  userRegister() async{
      setState((){loading=true;});
      final result = await RegisterDataHandler.register(
        email: emailController.text,
        password: passwordController.text,
        name: "Ahmed"
      );
      result.fold((l) {
        ToastHelper.showError(message: l.errorModel.statusMessage);
      }, (r) async {
       // await SharedPref.saveCurrentUser( user: r);
       // print("User ID saved: ${r.id}");

        // Retrieve user ID from the saved data
        final userId = SharedPref.getCurrentUser()?.user?.id;

        if (userId == null) {
          print("Error: User ID is null after registration");
          ToastHelper.showError(message: "Failed to fetch user ID");
          return;
        }
        print("Navigating to OTP screen with ID: ${SharedPref.getCurrentUser()?.user?.id}");


        // Navigate to VerificationOtpScreen with the correct ID
        currentContext_?.pushNamed(
          VerificationOtpScreen.routeName,
          extra: userId,
        );
        print("Navigated to OTP screen with extra ID: $userId");
        print("Logged-in user ID: ${SharedPref.getCurrentUser()?.user?.id}");

        setState(() {});
      });
      setState(() {
        loading = false;
      });

      await Future.delayed(const Duration(seconds: 2));
      setState((){loading=false;});
    }
}

