import 'package:mvc_pattern/mvc_pattern.dart';

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
    //  getPoliciesTerm();
  }
  @override
  void dispose() {
    super.dispose();
  }
}
