class APIEndPoint {
  static const String baseServerURL = "https://jetaime.petraright.com";
  static const String _baseURL = "$baseServerURL/api/user/";

  //=========================== api User ====================================
  static const String test = "${_baseURL}todos";
  static const String login = "${_baseURL}login";
  static const String logOut = "${_baseURL}logout";
  static const String register = "${_baseURL}register";
  static const String checkOtp = "${_baseURL}checkOtp";
  static const String resetPassword = "${_baseURL}reset-password";
  static const String reSentOtp = "${_baseURL}re-SentOTP";
  static const String home = "${_baseURL}home";
  static const String deleteAccount = "${_baseURL}delete-account";
  static const String newPassword = "${_baseURL}new-password";
  static const String postReview = "${_baseURL}store-review";
  static const String allNotifications = "${_baseURL}notifications";
  static const String categories = "${_baseURL}categories";
  static const String getOrdersList = "${_baseURL}orders";
  static const String addToCart = "${_baseURL}store-cart";
  static const String getCartList = "${_baseURL}carts";
  static const String getPopularProduct = "${_baseURL}get-product-poplar";
  static const String getFavorites = "${_baseURL}favorite";
  static const String addFavorite = "${_baseURL}store-favorite";
  static const String shippingForOrder = "${_baseURL}shipping-details";
  static const String checkOutCart = "${_baseURL}cart-detail";
  static const String getShippingDetails = "${_baseURL}get-shipping-details";
  static String showOrder(int orderId) => "${_baseURL}order/$orderId";
  static String readNotification(String notificationId) => "${_baseURL}read-notification/$notificationId";
  static String getOrderDetails(int orderId) => "${_baseURL}order/$orderId";
  static String getProductDetails(int productId) => "${_baseURL}show/$productId";
  static String deleteProductFromCart(int productId) => "${_baseURL}delete-cart/$productId";
  static  String getCategoriesProduct(int categoryProductId) => "${_baseURL}get-product-by-category/$categoryProductId";
  static String getReviews(int productId) =>
      "${_baseURL}get-reviews/$productId";
}
