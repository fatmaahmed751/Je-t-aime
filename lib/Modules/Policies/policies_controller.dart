import "package:je_t_aime/Modules/Policies/policies_data_handler.dart";
import 'package:mvc_pattern/mvc_pattern.dart';

import "../../Widgets/toast_helper.dart";

class PoliciesController extends ControllerMVC {
  // singleton
  factory PoliciesController() {
    _this ??= PoliciesController._();
    return _this!;
  }

  static PoliciesController? _this;

  PoliciesController._();

  bool loading = false;
  bool autoValidate = false;
  // PoliciesModel? policiesModel;
  String? privacyText;
  @override
  void initState() {
    super.initState();
  }

  init() {
//      getPoliciesTerm();
  }
  @override
  void dispose() {
    super.dispose();
  }
  // getPoliciesTerm() async {
  //   loading = true;
  //   setState(() {}
  //   );
  //   try {
  //     final result = await PolicesDataHandler.getPolicies();
  //     result.fold((l) {
  //       ToastHelper.showError(message: l.errorModel.statusMessage);
  //     }, (r) async {
  //       setState(() {
  //         policiesModel = r;
  //         loading = false;
  //       });
  //
  //       if (policiesModel?.privacyPolicy == null) {
  //         ToastHelper.showError(message: "No policies data available.");
  //       } else {
  //
  //       }
  //     });
  //   } catch (e) {
  //     // Handle exceptions
  //     print("Error occurred while fetching policies: $e");
  //     ToastHelper.showError(message: "Failed to fetch policies.");
  //   }
  //
  //   setState(() {
  //     loading = false;
  //   });
  // }
}


