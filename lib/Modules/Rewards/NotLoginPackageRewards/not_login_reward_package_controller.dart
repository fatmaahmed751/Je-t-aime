import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NotLoginRewardsPackageController extends ControllerMVC {
  // singleton
  factory NotLoginRewardsPackageController() {
    _this ??= NotLoginRewardsPackageController._();
    return _this!;
  }
  static NotLoginRewardsPackageController? _this;
  NotLoginRewardsPackageController._();
  bool loading=false,autoValidate = false;
  bool isClick = false;
  bool isSearch= false;
  int activeIndex=0;
  List imageUrl=[
  "https://s3-alpha-sig.figma.com/img/a040/2b4a/7d9d7ee419eaa09e1e2f88eedebd7303?Expires=1730678400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jrGk0hGVT7KQjZ~qrAZD5kFPAYBvc~n3KI7gsosmV73O4w8k5z~eYc~EAADnCpFxviZyYnCcE-cchOlpGvW9tKFsTUQcO8l2jbcxHHNBYc-AoXAsqqr8tkWjmWu2VcLI6cO1BZ8NfTjLVAf~5oV7PR2PPpSBmhjEApSfL4Aiq7isdZEYOodIOSJ8SpZ-piDhQi2TBnkDgOSnqLlDmILEQeBWEACQwdI03rHj-0fvphztJVUgMbfKa4O3b7cDfVNAMvRHWdmecLufa20qUJzZj3~vEq1uBhu0207L8G8xP5OYnLi7UVrU7td7XMWTc-68Mz7zMZt~wd~I97fDZAWNuA__",
  "https://s3-alpha-sig.figma.com/img/a040/2b4a/7d9d7ee419eaa09e1e2f88eedebd7303?Expires=1730678400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jrGk0hGVT7KQjZ~qrAZD5kFPAYBvc~n3KI7gsosmV73O4w8k5z~eYc~EAADnCpFxviZyYnCcE-cchOlpGvW9tKFsTUQcO8l2jbcxHHNBYc-AoXAsqqr8tkWjmWu2VcLI6cO1BZ8NfTjLVAf~5oV7PR2PPpSBmhjEApSfL4Aiq7isdZEYOodIOSJ8SpZ-piDhQi2TBnkDgOSnqLlDmILEQeBWEACQwdI03rHj-0fvphztJVUgMbfKa4O3b7cDfVNAMvRHWdmecLufa20qUJzZj3~vEq1uBhu0207L8G8xP5OYnLi7UVrU7td7XMWTc-68Mz7zMZt~wd~I97fDZAWNuA__",
  "https://s3-alpha-sig.figma.com/img/a040/2b4a/7d9d7ee419eaa09e1e2f88eedebd7303?Expires=1730678400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jrGk0hGVT7KQjZ~qrAZD5kFPAYBvc~n3KI7gsosmV73O4w8k5z~eYc~EAADnCpFxviZyYnCcE-cchOlpGvW9tKFsTUQcO8l2jbcxHHNBYc-AoXAsqqr8tkWjmWu2VcLI6cO1BZ8NfTjLVAf~5oV7PR2PPpSBmhjEApSfL4Aiq7isdZEYOodIOSJ8SpZ-piDhQi2TBnkDgOSnqLlDmILEQeBWEACQwdI03rHj-0fvphztJVUgMbfKa4O3b7cDfVNAMvRHWdmecLufa20qUJzZj3~vEq1uBhu0207L8G8xP5OYnLi7UVrU7td7XMWTc-68Mz7zMZt~wd~I97fDZAWNuA__",
  ];
//  List<BannerModel> products=[];
  var boardController = PageController();
  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }
  onPageChange(int index)
  {
    setState(() {activeIndex=index; });
    activeIndex=index;
  }
  // Future getProducts() async {
  //   loading=true;
  //   setState(() { });
  //   final result = await PopularProductsDataHandler.getProducts();
  //   result.fold((l) =>ToastHelper.showError(message: l.toString()),(r) {
  //     products=r;
  //   });
  //   setState(() {loading=false;});
  // }
  userRewards()async{
    setState((){loading=true;});
    await Future.delayed(const Duration(seconds: 2));
    setState((){loading=false;});
  }
}
