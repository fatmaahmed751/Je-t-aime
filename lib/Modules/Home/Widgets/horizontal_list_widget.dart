import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:je_t_aime/core/Language/locales.dart';

import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Widgets/custom_details_side_text.dart';

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
    return Container(
      //color: Colors.red,
      child: Column(
        children: [
          if (title.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDetailsSideTextWidget(
                      text: title),
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
              itemCount:
             itemsList.length,
              scrollDirection: Axis.horizontal,
              padding:
              EdgeInsets.symmetric(horizontal: title.isNotEmpty ? 16.w : 0),
              itemBuilder: (_, index) => buildWidget(itemsList[index]),
              separatorBuilder: (_, __) => Gap(separateValue ?? 16.w),
            ),
          ),
        ],
      ),
    );
  }
}