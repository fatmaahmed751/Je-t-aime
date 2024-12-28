import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/Models/category_model.dart';
import 'package:je_t_aime/Widgets/custom_side_text_widget.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Models/user_model.dart';
import '../../Utilities/shared_preferences.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/custom_app_bar_widget.dart';
import '../../Widgets/custom_details_side_text.dart';
import '../../Widgets/loading_screen.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends StateMVC<HomeScreen> {
  _HomeScreenState() : super(HomeController()) {
    con = HomeController();
  }
  late HomeController con;
  @override
  void initState() {
    super.initState();
  }

//     HomeController().controller.addListener(_updateView);
// }
//   @override
//   void dispose() {
//     // Remove the listener when the screen is disposed
//     HomeController().controller.removeListener(_updateView);
//     super.dispose();
//   }
//   void _updateView() {
//     // Define what should happen when the controller state changes
//     setState(() {
//       // Update the UI or trigger some action here
//     });
//
//   }
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    // print(SharedPref.getCurrentUser()?.token);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 180.h),
          child: CustomAppBarWidget.secondaryAppBar(
            title: "",
            icon: "",
          )),
      // bottomNavigationBar: BottomNavBarWidget(
      //   selected: SelectedBottomNavBar.home,
      body: RefreshIndicator(
        onRefresh: () async {
          // con.init();
        },
        child: LoadingScreen(
          loading: con.loading,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(16.h),
                CustomDetailsSideTextWidget(
                  text: Strings.categories.tr,
                ),
               Gap(16.h),
               SizedBox(
                 height: 200.h,
                // width: MediaQuery.sizeOf(context).width,
                 child: ListView.separated(
                   scrollDirection: Axis.horizontal,
                     itemBuilder: (context,index)=>CategoriesWidget(categoryModel:con.categoryModel[index],),
                     separatorBuilder:(context,index)=>Gap(10.w),
                     itemCount: con.categoryModel.length),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CategoriesWidget extends StatelessWidget{
  final CategoryModel categoryModel;

  const CategoriesWidget({super.key, required this.categoryModel});
  @override
  Widget build(BuildContext context) {
  return   SizedBox(
    width: 104.w,
    height: 136.h,
    child: Column(
      children: [
        CircleAvatar(
            radius:50.r,
            backgroundImage:
            NetworkImage(
             categoryModel.imageName ),),
        Gap(6.h),
        CustomSideTextWidget(text:categoryModel.mainText )
      ],
    ),
  );
  }

}
class HorizontalListWidget<T> extends StatelessWidget {
  final String title;
  final String? viewAllRouteName;
  final double itemHeight;
  final double? separateValue;
  final List<T> itemsList;
  final Widget Function(T) buildWidget;

  const HorizontalListWidget(
      {super.key,
      required this.title,
      this.viewAllRouteName,
      required this.itemHeight,
      required this.buildWidget,
      this.separateValue,
      required this.itemsList});

  factory HorizontalListWidget.onlyListView(
      {required double itemHeight,
      required List<T> itemsList,
      required Widget Function(T) buildWidget,
      double? separateValue}) {
    return HorizontalListWidget(
      buildWidget: buildWidget,
      itemHeight: itemHeight,
      itemsList: itemsList,
      separateValue: separateValue,
      title: "",
      viewAllRouteName: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    if (itemsList.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyleHelper.of(context).h_20,
                ),
                if (viewAllRouteName != null)
                  InkWell(
                    onTap: () => context.pushNamed(viewAllRouteName!),
                    child: Text(
                      Strings.viewAll.tr,
                      style: TextStyleHelper.of(context).b_14.copyWith(
                          decoration: TextDecoration.underline,
                          color: ThemeClass.of(context).primaryColor),
                    ),
                  ),
              ],
            ),
          ),
        if (title.isNotEmpty) Gap(8.h),
        SizedBox(
          height: itemHeight,
          child: ListView.separated(
            itemCount: itemsList.length,
            scrollDirection: Axis.horizontal,
            padding:
                EdgeInsets.symmetric(horizontal: title.isNotEmpty ? 16.w : 0),
            itemBuilder: (_, index) => buildWidget(itemsList[index]),
            separatorBuilder: (_, __) => Gap(separateValue ?? 16.w),
          ),
        ),
      ],
    );
  }
}
