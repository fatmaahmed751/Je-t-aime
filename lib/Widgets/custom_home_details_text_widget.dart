import 'package:flutter/material.dart';

import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';

class CustomHomeDetailsTextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  const CustomHomeDetailsTextWidget(
      {super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}
