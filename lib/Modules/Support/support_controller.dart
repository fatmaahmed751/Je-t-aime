import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_bottom_sheet_widget.dart';
import '../../generated/assets.dart';

class SupportController extends ControllerMVC {
  // singleton
  factory SupportController() {
    _this ??= SupportController._();
    return _this!;
  }

  static SupportController? _this;

  SupportController._();
  bool loading=false;
  bool autoValidate = false;
  late TextEditingController problemController,
  emailController,
   phoneController ,
  nameController;


  @override
  void initState() {
    problemController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    nameController = TextEditingController();
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
      builder:(context)=>const CustomBottomSheetWidget(
        image:Assets.imagesSubmit,
        text: "hhhhhhhh",
      ),
    );
  }
  // submitProblemSuccessfully() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   final result = await SupportDataHandler.support(
  //       problem:problemController.text,
  //       email: emailController.text,
  //       phone: phoneController.text
  //
  //   );
  //   result.fold((l) {
  //     ToastHelper.showError(message: l.errorModel.statusMessage);
  //   }, (r) async {
  //     setState(() {});
  //     showDialog(
  //       context: currentContext_!,
  //       builder: (context) =>  AlertRateProductSuccessfully(
  //         firstText:Strings.sendYourProblem.tr ,
  //         secondText:Strings.sendingProblemSuccessfully.tr ,
  //       ),
  //     );
  //   }
  //   );
  //   setState(() {
  //     loading = false;
  //   });
  // }
}