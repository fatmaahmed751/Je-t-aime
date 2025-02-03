import "package:flutter/cupertino.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart";

class PaginationWidget extends StatelessWidget {
  final RefreshController refreshController;
  final Widget child;
  final Function() onRefresh,onLoading;
  const PaginationWidget({super.key,required this.child,
    required this.refreshController, required this.onRefresh, required this.onLoading});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus? mode){
          Widget child = switch(mode){
            LoadStatus.idle=> const Text("pull up load"),
            LoadStatus.loading=> const CupertinoActivityIndicator(),
            LoadStatus.failed=> const Text("Load Failed!Click retry!"),
            LoadStatus.canLoading=> const Text("release to load more"),
            LoadStatus.noMore=> const SizedBox(),
            null=> const SizedBox(),
          };
          return SizedBox(
            height: 48.h,
            child: Center(child: child),
          );
        },
      ),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: child,
    );
  }
}
