import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SearchScreenController extends ControllerMVC {
  // singleton
  factory SearchScreenController() {
    _this ??= SearchScreenController._();
    return _this!;
  }
  static SearchScreenController? _this;
  bool isSearch=false;
  late TextEditingController controller;
  bool isLiked=false;//in model when link
  SearchScreenController._();


  @override
  void initState() {
    super.initState();
    controller=TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}