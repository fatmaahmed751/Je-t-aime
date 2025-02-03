import 'package:flutter/material.dart';

import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';

class CustomDetailsSideTextWidget extends StatelessWidget {
  final String text;
  const CustomDetailsSideTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyleHelper.of(context)
          .h_20
          .copyWith(color: ThemeClass.of(context).sideText),
    );
  }
}
