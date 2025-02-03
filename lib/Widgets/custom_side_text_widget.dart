import 'package:flutter/material.dart';

import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';

class CustomSideTextWidget extends StatelessWidget {
  final String text;
  const CustomSideTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyleHelper.of(context)
          .b_20
          .copyWith(color: ThemeClass.of(context).mainBlack),
    );
  }
}
