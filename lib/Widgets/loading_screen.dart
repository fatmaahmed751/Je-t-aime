import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utilities/theme_helper.dart';

class LoadingScreen extends StatelessWidget {
  final Widget child;
  final bool loading;
  final Color? color;
  const LoadingScreen({
    Key? key,
    required this.child,
    this.loading = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          if (loading)
            Positioned.fill(
              child: Container(
                color:
                    color ?? ThemeClass.of(context).mainBlack.withAlpha((0.2* 255).toInt()),
              ),
            ),
          if (loading)
            Positioned(
              child: Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha((0.9* 255).toInt()),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: CupertinoActivityIndicator(
                  radius: 25.r,
                  color: ThemeClass.of(context).secondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
