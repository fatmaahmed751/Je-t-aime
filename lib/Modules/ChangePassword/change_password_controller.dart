import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:je_t_aime/Widgets/custom_bottom_sheet_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../generated/assets.dart';

class ChangePasswordController extends ControllerMVC {
  // singleton
  factory ChangePasswordController() {
    _this ??= ChangePasswordController._();
    return _this!;
  }
  static ChangePasswordController? _this;
  ChangePasswordController._();
  bool loading = false, autoValidate = false;
  late TextEditingController newPasswordController;
  late TextEditingController oldPasswordController;
  late TextEditingController confirmNewPasswordController;
  bool isPassword = true;
  bool newPassword = true;
  bool repeatPassword = true;
  @override
  void initState() {
    newPasswordController = TextEditingController();
    oldPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    oldPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) => CustomBottomSheetWidget(
        image: Assets.imagesSubmit,
        text: Strings.doneChangePassword.tr,
      ),
    );
  }
}
