import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:je_t_aime/Models/cart_details_model.dart";
import "package:je_t_aime/Models/category_model.dart";
import "package:je_t_aime/Models/popular_products_model.dart";
import "package:je_t_aime/Models/product_details_model.dart";
import "package:je_t_aime/Models/shipping_product_model.dart";
import "package:je_t_aime/Models/shipping_product_model.dart";
import "package:je_t_aime/Modules/ChangePassword/change_password_screen.dart";
import "package:je_t_aime/Modules/Favorite/favorite_screen.dart";
import "package:je_t_aime/Modules/Notifications/notifications_screen.dart";
import "package:je_t_aime/Modules/Orders/orders_screen.dart";
import "package:je_t_aime/Modules/Payment/payment_screen.dart";
import "package:je_t_aime/Modules/Register/register_screen.dart";
import "package:je_t_aime/Modules/Support/support_screen.dart";
import "package:je_t_aime/Utilities/shared_preferences.dart";
import "../Models/cart_item_model.dart";
import "../Models/categories_product_model.dart";
import "../Modules/AllCategories/all_categories_screen.dart";
import "../Modules/Cart/cart_screen.dart";
import "../Modules/ForgetPassword/forget_password_screen.dart";
import "../Modules/Home/SearchSccreen/search_screen.dart";
import "../Modules/Home/home_screen.dart";
import "../Modules/Login/login_screen.dart";
import "../Modules/OnBoarding/onboarding_screen.dart";
import "../Modules/PersonalData/personal_data_screen.dart";
import "../Modules/Policies/policies_screen.dart";
import "../Modules/PopularProducts/popular_product_screen.dart";
import "../Modules/ProductDetails/product_details_screen.dart";
import "../Modules/ResetPassword/reset_password_screen.dart";
import "../Modules/ResetPassword/widget/verify_password_otp.dart";
import "../Modules/Reviews/reviews_screen.dart";
import "../Modules/Rewards/LoginRewardsScreen/login_rewards_screen.dart";
import "../Modules/Shipping/shipping_screen.dart";
import "../Modules/Splash/splash_screen.dart";
import "../Modules/UserProfile/user_profile_screen.dart";
import "../Modules/VerificationAccountOtp/verification_otp_screen.dart";

BuildContext? get currentContext_ =>
    GoRouterConfig.router.routerDelegate.navigatorKey.currentContext;

class GoRouterConfig {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: SplashScreen.routeName,
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const SplashScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),

      GoRoute(
        name: AllCategoriesScreen.routeName,
        path: "/${AllCategoriesScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          final CategoryModel model = state.extra as CategoryModel;
          print(state.extra);
          return getCustomTransitionPage(
            state: state,
            child:  AllCategoriesScreen(
              //categoryProductModel: state.extra as CategoryProductModel,
              model: model,
               categoryProductModel: CategoryProductModel(),
            ),

          );
        },

        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: HomeScreen.routeName,
        path: "/${HomeScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const HomeScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: SearchScreen.routeName,
        path: "/${SearchScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const SearchScreen(
              search: "",
            ),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: PopularProductsScreen.routeName,
        path: "/${PopularProductsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
         final List<PopularProductsModel> products = state.extra as List<PopularProductsModel>;
          return getCustomTransitionPage(
            state: state,
            child:  PopularProductsScreen(
              products: products,
            ),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: CartScreen.routeName,
        path: "/${CartScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
         // final List<CartModel> products = state.extra as List<CartModel>;
          return getCustomTransitionPage(
            state: state,
            child:  CartScreen(
            //  products: products,
            ),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ShippingScreen.routeName,
        path: "/${ShippingScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          final args = state.extra as Map<String, dynamic>;
          return getCustomTransitionPage(
            state: state,
            child: ShippingScreen(
                subtotal: (args["subtotal"] as int).toDouble(), // Convert int to double
                shippingCost: (args["shippingCost"] as int).toDouble(),
                // subtotal: args["subtotal"] ,
                // shippingCost: args["shippingCost"] ,
                products:args["products"] as List<CartModel>)
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ReviewsForProductScreen.routeName,
        path: "/${ReviewsForProductScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          final int productId = state.extra as int;
         // final PopularProductsModel model = state.extra as PopularProductsModel;
          return getCustomTransitionPage(
            state: state,
            child:  ReviewsForProductScreen(
             productId: productId,
            ),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ProductDetailsScreen.routeName,
        path: "/${ProductDetailsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          final int productId = state.extra as int;
         // final PopularProductsModel model = state.extra as PopularProductsModel;
          return getCustomTransitionPage(
            state: state,
            child:  ProductDetailsScreen(
              productId: productId,

            ),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: PaymentScreen.routeName,
        path: "/${PaymentScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
       //  final ShippingProductModel model = state.extra as ShippingProductModel;
          return getCustomTransitionPage(
            state: state,
            child:  PaymentScreen(
              //shippingProductModel: model,
            ),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: OnBoardingScreen.routeName,
        path: "/${OnBoardingScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const OnBoardingScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: LoginRewardsScreen.routeName,
        path: "/${LoginRewardsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const LoginRewardsScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: FavoriteScreen.routeName,
        path: "/${FavoriteScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const FavoriteScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: UserProfileScreen.routeName,
        path: "/${UserProfileScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const UserProfileScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: PersonalDataScreen.routeName,
        path: "/${PersonalDataScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const PersonalDataScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: OrdersScreen.routeName,
        path: "/${OrdersScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const OrdersScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: SupportScreen.routeName,
        path: "/${SupportScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const SupportScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: PoliciesScreen.routeName,
        path: "/${PoliciesScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const PoliciesScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: VerificationOtpScreen.routeName,
        path: "/${VerificationOtpScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          final int id = int.tryParse(state.extra?.toString() ?? "") ?? 0;
          final loggedInUserId = SharedPref.getCurrentUser()?.user?.id;
          if (loggedInUserId != id) {
            print("ID mismatch: This is not the logged-in user's ID.");
          }
          return getCustomTransitionPage(
            state: state,
            child: VerificationOtpScreen(id: id),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ForgetPasswordScreen.routeName,
        path: "/${ForgetPasswordScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const ForgetPasswordScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: VerificationPasswordScreen.routeName,
        path: "/${VerificationPasswordScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          final String email = state.extra as String;
          return getCustomTransitionPage(
            state: state,
            child: VerificationPasswordScreen(email: email),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: RegisterScreen.routeName,
        path: "/${RegisterScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const RegisterScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ResetPasswordScreen.routeName,
        path: "/${ResetPasswordScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          final int id = int.tryParse(state.extra?.toString() ?? "") ?? 0;
          final loggedInUserId = SharedPref.getCurrentUser()?.user?.id;
          print("Passed ID: $id");
          print("Logged In User ID: $loggedInUserId");

          if (loggedInUserId != id) {
            print("ID mismatch: This is not the logged-in user's ID.");
          }
          return getCustomTransitionPage(
            state: state,
            child: ResetPasswordScreen(id: id),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: NotificationsScreen.routeName,
        path: "/${NotificationsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const NotificationsScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: "/${LoginScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const LoginScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ChangePasswordScreen.routeName,
        path: "/${ChangePasswordScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const ChangePasswordScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   if(!SharedPref.isLogin()) return LoginScreen.routeName;
    //   if(state.matchedLocation == LoginScreen.routeName && SharedPref.isLogin()) return "/${HomeScreen.routeName}";
    //
    //   if(state.matchedLocation == OTPScreen.routeName && state.extra == null){
    //     return ForgetPasswordScreen.routeName;
    //   }
    //   return null;
    // },
  );

  static CustomTransitionPage getCustomTransitionPage(
      {required GoRouterState state, required Widget child}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}
