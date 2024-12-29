import 'package:mvc_pattern/mvc_pattern.dart';


class AllCategoriesController extends ControllerMVC {
  // singleton
  factory AllCategoriesController() {
    _this ??= AllCategoriesController._();
    return _this!;
  }

  static AllCategoriesController? _this;
  bool loading = false;

  AllCategoriesController._();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  init(){
    getAllCategories();
  }
  Future getAllCategories() async {
    loading=true;

    setState(() {loading=false;});
  }
}