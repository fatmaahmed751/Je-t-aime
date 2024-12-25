import 'package:flutter/material.dart';

import '../../Utilities/shared_preferences.dart';
import '../../Utilities/theme_helper.dart';


class ThemeModel extends ThemeExtension<ThemeModel>{

  static ThemeModel get defaultTheme{
    return ThemeClass.darkTheme();
    // Brightness brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    // return brightness == Brightness.dark? ThemeClass.darkTheme():ThemeClass.lightTheme();
  }

  final bool isDark;
  final Color background;
  final Color primaryColor;
  final Color mainSecondary;
  final Color mainBlack;
  final Color pinkColor;
  final Color secondaryBlackColor;
  final Color labelColor;
  final Color containerColor;
  final Color descTextColor;
  final Color success;
  final Color waiting;
  final Color cancel;
  final Color secondary;
  final Color sideText;

  ThemeModel({
    this.isDark = false,
    required this.background,
    required this.primaryColor,
    required this.mainSecondary,
    required this.labelColor,
    required this.success,
    required this.waiting,
    required this.cancel,
    required this.secondary,
    required this.mainBlack,
    required this.secondaryBlackColor,
    required this.containerColor,
    required this.descTextColor,
    required this.sideText,
    required this.pinkColor
});

  @override
  ThemeModel copyWith({
    bool? isDark,
    Color? reversedBlackWhite,
    Color? background,
    Color? primaryColor,
    Color? pTint1,
    Color? pTint2,
    Color? pShade1,
    Color? secondary,
    Color? regPrimary,
    Color? regSecondary,
    Color? regFieldBorder,
    Color? sTint1,
    Color? sTint2,
    Color? shade1,
    Color? cardLight,
    Color? labelColor,
    Color? success,
    Color? waiting,
    Color? cancel,
    Color? informative,
    Color? mainBlack,
    Color? bodyColor,
    Color? tabBarColor,
    Color? containerColor,
    Color?descTextColor,
    Color?sideText,
    Color?pinkColor
}) {
    return ThemeModel(
      isDark: isDark??this.isDark,
      background: background??this.background,
      primaryColor: primaryColor??this.primaryColor,
      mainSecondary: secondary??this.mainSecondary,
      labelColor: labelColor??this.labelColor,
      success: success??this.success,
      waiting: waiting??this.waiting,
      cancel: cancel??this.cancel,
      secondary: informative??this.secondary,
      mainBlack: mainBlack??this.mainBlack,
      secondaryBlackColor: bodyColor??this.secondaryBlackColor,
        containerColor:containerColor??this.containerColor,
        descTextColor:descTextColor??this.descTextColor,
        sideText:sideText??this.sideText,
        pinkColor:pinkColor??this.pinkColor
    );
  }

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
    isDark: json["isDark"],
    background: Color(json["background"]),
    primaryColor: Color(json["primaryColor"]),
    mainSecondary: Color(json["secondary"]),
    labelColor: Color(json["labelColor"]),
    success: Color(json["success"]),
    waiting: Color(json["waiting"]),
    cancel: Color(json["cancel"]),
    secondary: Color(json["informative"]),
    mainBlack: Color(json["mainBlack"]),
    secondaryBlackColor: Color(json["bodyColor"]),
    containerColor: Color(json["containerColor"]),
      descTextColor:Color(json["descTextColor"]),
      sideText:Color(json["sideText"]),
      pinkColor:Color(json["pinkColor"]),
  );

  Map<String, dynamic> toJson() => {
    "isDark": isDark,
    "background": background.value,
    "primaryColor": primaryColor.value,
    "secondary": mainSecondary.value,
    "labelColor": labelColor.value,
    "success": success.value,
    "waiting": waiting.value,
    "cancel": cancel.value,
    "informative": secondary.value,
    "mainBlack": mainBlack.value,
    "bodyColor": secondaryBlackColor.value,
    "containerColor":containerColor.value,
    "descTextColor":descTextColor.value,
    "sideText":sideText.value,
    "pinkColor":pinkColor.value
  };


  @override
  ThemeModel lerp(ThemeExtension<ThemeModel>? other, double t) {
    if (other is! ThemeModel) {
      return this;
    }
    return SharedPref.getTheme()??defaultTheme;
  }
}