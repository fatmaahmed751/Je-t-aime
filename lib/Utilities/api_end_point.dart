class APIEndPoint {
  static const String baseServerURL = "https://jetaime.petraright.com";
  static const String _baseURL = "$baseServerURL/api/";

  //=========================== api User ====================================
  static const String test = "${_baseURL}todos";
  static const String login = "${_baseURL}user/login";
  static const String register = "${_baseURL}user/register";
  static const String checkOtp = "${_baseURL}user/checkOtp";
  static const String resetPassword = "${_baseURL}user/reset-password";
  static const String reSentOtp = "${_baseURL}user/re-SentOTP";
  static const String category = "${_baseURL}user/home";
  static const String newPassword = "${_baseURL}user/new-password";
  static const String postReview = "${_baseURL}user/store-review";
  static String getReviews(int productId) =>
      "${_baseURL}user/get-reviews/$productId";
}
