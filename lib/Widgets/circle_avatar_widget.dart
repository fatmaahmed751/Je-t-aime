import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../Utilities/theme_helper.dart';
import '../../../../generated/assets.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: CircleAvatar(
        radius: 8.r,
        backgroundColor: ThemeClass.of(context).background,
        child: SvgPicture.asset(
          Assets.imagesArrowBack,
        ),
      ),
    );
  }
}
