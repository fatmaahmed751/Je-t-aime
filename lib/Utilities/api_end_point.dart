class APIEndPoint {
  static const String baseServerURL = "https://jetaime.petraright.com";
  static const String _baseURL = "$baseServerURL/api/user/";

  //=========================== api User ====================================
  static const String test = "${_baseURL}todos";
  static const String login = "${_baseURL}login";
  static const String register = "${_baseURL}register";
  static const String checkOtp = "${_baseURL}checkOtp";
  static const String resetPassword = "${_baseURL}reset-password";
  static const String reSentOtp = "${_baseURL}re-SentOTP";
  static const String category = "${_baseURL}home";
  static const String newPassword = "${_baseURL}new-password";
  static const String postReview = "${_baseURL}store-review";
  static const String categories = "${_baseURL}categories";
  static const String addToCart = "${_baseURL}store-cart";
  static const String addFavorite = "${_baseURL}store-favorite";
  static String getProductDetails(int productId) =>
      "${_baseURL}show/$productId";
  static  String getCategoriesProduct(int categoryProductId) => "${_baseURL}get-product-by-category/$categoryProductId";
  static String getReviews(int productId) =>
      "${_baseURL}get-reviews/$productId";
}
