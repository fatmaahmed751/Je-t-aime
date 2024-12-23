import 'package:flutter/material.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Utilities/strings.dart';
import '../../../generated/assets.dart';
import '../../Models/on_boarding_model.dart';

class OnBoardingController extends ControllerMVC {
  // singleton
  factory OnBoardingController() {
    _this ??= OnBoardingController._();
    return _this!;
  }

  static OnBoardingController? _this;

  OnBoardingController._();

  PageController controller = PageController();

  List<OnBoardingModel> onBoarding = [
    OnBoardingModel(
      id: 0,
      skipText: Strings.skip.tr,
      imageName: Assets.imagesOnBoardingOne,
      mainText: Strings.onBoardingMainTextOne.tr,
      subText: Strings.onBoardingDescTextOne.tr,
    ),
    OnBoardingModel(
      id:1,
      skipText: Strings.skip.tr,
      imageName:Assets.imagesOnBoardingTwo,
      mainText: Strings.onBoardingMainTextTwo.tr,
      subText: Strings.onBoardingDescTextTwo.tr,
    ),
    OnBoardingModel(
      id:2,
      skipText: "",
      imageName:Assets.imagesOnBoardingThree,
      mainText: Strings.onBoardingMainTextThree.tr,
      subText: Strings.onBoardingDescTextThree.tr,
    ),
  ];
  bool isLast = false;
  int index = 0;
  onNext(){
    controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }
  onPrevious(){
    controller.previousPage(duration: const Duration(milliseconds:500), curve: Curves.linear);
  }
}
