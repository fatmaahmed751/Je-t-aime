import 'package:flutter/material.dart';

import '../../../../Utilities/text_style_helper.dart';
import '../../../../Utilities/theme_helper.dart';

class UserStatusRow extends StatelessWidget {
  final String text;
  final String nextText;
  final void Function() onNextTextTap;
  const UserStatusRow({
    super.key, required this.text, required this.nextText,
    required this.onNextTextTap

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyleHelper.of(context).b_16.copyWith(
              color: ThemeClass.of(context).secondary),
        ),
        TextButton(
          onPressed:onNextTextTap ,
          child: Text(
            nextText,
            style: TextStyleHelper.of(context).b_16.copyWith(
                color: ThemeClass.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}