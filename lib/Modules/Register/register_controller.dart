
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
  // UserModel? userModel;
   bool isPassword = true;
  bool isConfirmPassword = true;
  // final AuthController _authController = AuthController();
  // GoogleSignInAccount? currentUser;
  @override
  void initState() {
    emailController=TextEditingController();
    passwordController=TextEditingController();
    confirmPasswordController=TextEditingController();
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
  //


}
