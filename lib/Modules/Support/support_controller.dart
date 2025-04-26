import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:je_t_aime/Modules/Support/support_data_handler.dart";
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import "../../Utilities/shared_preferences.dart";
import '../../Utilities/strings.dart';
import '../../Widgets/custom_bottom_sheet_widget.dart';
import "../../Widgets/toast_helper.dart";
import '../../generated/assets.dart';

class SupportController extends ControllerMVC {
  // singleton
  factory SupportController() {
    _this ??= SupportController._();
    return _this!;
  }

  static SupportController? _this;

  SupportController._();
  bool loading = false;
  bool autoValidate = false;
  late TextEditingController problemController,
      emailController,
      phoneController,
      nameController;

  @override
  void initState() {
    problemController = TextEditingController();
    emailController = TextEditingController(text:"${SharedPref.getCurrentUser()?.user?.email}"??"");
    phoneController = TextEditingController();
    nameController = TextEditingController(text:"${SharedPref.getCurrentUser()?.user?.name}"??"");
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    problemController.dispose();
    nameController.dispose();
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
        image: Assets.imagesSubmitProblem,
        text: Strings.thanksForTrust.tr,
      ),
    );
  }

  submitProblemSuccessfully(BuildContext context) async {
    setState(() {
      loading = true;
    });
    final result = await SupportDataHandler.support(
        problem: problemController.text,
        email: emailController.text,
        phone: phoneController.text,
        name: nameController.text);
    result.fold((l) {
      ToastHelper.showError(message: l.errorModel.statusMessage);
    }, (r) async {
      setState(() {});

      showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => CustomBottomSheetWidget(
          image: Assets.imagesSubmitProblem,
          text: Strings.thanksForTrust.tr,
        ),
      );
    });
    setState(() {
      loading = false;
    });
  }
}
