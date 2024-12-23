import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/Theme/theme_model.dart';
import '../core/Theme/theme_provider.dart';

class ThemeClass extends ThemeModel{

  static ThemeModel of(BuildContext context) => Provider.of<ThemeProvider>(context,listen: false).appTheme;


  static List<Color> get backgroundGradiant => const [
    Color.fromRGBO(122, 67, 67, 1),
    Color.fromRGBO(216, 143, 143, 1),
    Color.fromRGBO(203, 227, 227, 1),
  ];

  ThemeClass.lightTheme({
    super.isDark = false,
    super.background = const Color(0xffFFFFFF),
    super.primaryColor = const Color(0xff7A4343),
    super.mainSecondary = const Color(0xffE3CBCB),
    super.secondary = const Color(0xffE8E8E8),
    super.labelColor = const Color(0xffBBBBBB),
    super.mainBlack = const Color(0xff1F1F1F),
    super.secondaryBlackColor = const Color(0xff606060),
    super.waiting = const Color(0xffF68524),
    super.cancel = const Color(0xffEA3829),
    super.success = const Color(0xff00B060),

  });

  ThemeClass.darkTheme({
    super.isDark = true,
    super.background = const Color(0xffFFFFFF),
    super.primaryColor = const Color(0xff7A4343),
    super.mainSecondary = const Color(0xffE3CBCB),
    super.secondary = const Color(0xffE8E8E8),
    super.labelColor = const Color(0xffBBBBBB),
    super.mainBlack = const Color(0xff1F1F1F),
    super.secondaryBlackColor = const Color(0xff606060),
    super.waiting = const Color(0xffF68524),
    super.cancel = const Color(0xffEA3829),
    super.success = const Color(0xff00B060),
  });
}
class BackGroundClass {

  static List<Color> get backgroundGradiant => const [
    Color.fromRGBO(241, 128, 107, 0.19),
    Color.fromRGBO(236, 174, 114, 0.28),
    Color.fromRGBO(244, 201, 150, 0.23),
    Color.fromRGBO(163, 114, 80, 0.25),
    Color.fromRGBO(210, 199, 238, 0.22),
    Color.fromRGBO(254, 242, 205, 0.69),
  ];

}