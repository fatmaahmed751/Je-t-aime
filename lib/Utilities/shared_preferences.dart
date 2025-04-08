import "dart:convert";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../Models/cart_item_model.dart";
import "../core/Font/font_provider.dart";
import "../core/Language/app_languages.dart";
import "../core/Theme/theme_model.dart";
import "../Models/user_model.dart";

class SharedPref {
  static SharedPreferences get prefs => GetIt.instance.get<SharedPreferences>();
  static const String _language = "language_code";
  static const String _currentUserKey = "currentUser";
  static const String _themeKey = "theme";
  static const String _cartKey = "cartProducts";
  static const String _fontSizeKey = "fontSize";
  static const String _fontFamilyKey = "fontFamily";
  static const String _secondaryColor = "secondaryColor";
  static const String _chatCount = "chatCount";
  static const String _primaryColor = "primaryColor";
  static const String _notifStatus = 'notificationStatus';

  static UserModel? getCurrentUser() {
    if (prefs.getString(_currentUserKey) == null) return null;
    return UserModel.fromJson(json.decode(prefs.getString(_currentUserKey)!));
  }

  static Future<bool> saveCurrentUser({required UserModel user}) async {
    return await prefs.setString(_currentUserKey, json.encode(user.toJson()));
  }

  static bool isLogin() => prefs.getString(_currentUserKey) != null;



  static ThemeModel? getTheme() {
    if (prefs.getString(_themeKey) == null) return null;
    return ThemeModel.fromJson(json.decode(prefs.getString(_themeKey)!));
  }
  static int? getChatCount(){
    return prefs.getInt(_chatCount);
  }
  static Future<bool> saveTotalChatCount({required int chatCount}) async {
    return await prefs.setInt(_chatCount, chatCount);
  }
  static int? getTotalChatCount(){
    return prefs.getInt(_chatCount);
  }

  static Future<void> setTheme({required ThemeModel theme}) async {
    await prefs.setString(_themeKey, json.encode(theme.toJson()));
  }
  //My code
  static Future<void> logout() async {
    await prefs.remove("userToken");
    await prefs.remove(_currentUserKey);
  }

  static Future<void> saveCart(List<CartModel> cartProducts) async {
    final cartJson = cartProducts.map((item) => item.toJson()).toList();
    final cartString = jsonEncode(cartJson);
    await prefs.setString(_cartKey, cartString);
  }
  static Future<List<CartModel>> getCart() async {
    final cartString = prefs.getString(_cartKey);
    if (cartString == null) return [];
    final cartJson = jsonDecode(cartString) as List<dynamic>;
    return cartJson.map((item) => CartModel.fromJson(item)).toList();
  }

  static Future<void> clearCart() async {
    await prefs.remove(_cartKey);
  }

//
  static double? getFontSizeScale() {
    return prefs.getDouble(_fontSizeKey);
  }

  static Future<void> setFontSizeScale({required double fontSizeScale}) async {
    await prefs.setDouble(_fontSizeKey, fontSizeScale);
  }

  static Color? getPrimaryColor() {
    if (prefs.getInt(_primaryColor) == null) return null;
    return Color(prefs.getInt(_primaryColor)!);
  }

  static Future<void> setPrimaryColor({required Color color}) async {
    await prefs.setInt(_primaryColor, color.value);
  }

  static Color? getSecondaryColor() {
    if (prefs.getInt(_secondaryColor) == null) return null;
    return Color(prefs.getInt(_secondaryColor)!);
  }

  static Future<void> setSecondaryColor({required Color color}) async {
    await prefs.setInt(_secondaryColor, color.value);
  }

  static Future setFontFamily({required FontFamilyTypes fontFamily}) async =>
      await prefs.setInt(_fontFamilyKey, fontFamily.index);
  static FontFamilyTypes? getFontFamily() =>
      prefs.getInt(_fontFamilyKey) == null
          ? null
          : FontFamilyTypes.values[prefs.getInt(_fontFamilyKey)!];

  static String? getLanguage() => prefs.getString(_language);

  static String getCurrentLanguage() =>
      prefs.getString(_language) ?? (appLangIsArabic() ? "ar" : "en");

  static Future<void> setLanguage({required String lang}) async =>
      await prefs.setString(_language, lang);
}
