import 'package:firebase_sample/utilities/colors.dart';
import 'package:flutter/material.dart';

class HelperText extends StatelessWidget {
  HelperText({
    this.helperText,
    this.isRequired,
  });

  final String? helperText;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final helperTextStyle = textTheme.bodyText1;

    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: helperText,
            style: helperTextStyle,
          ),
          if (isRequired!)
            TextSpan(
              text: ' *',
              style: helperTextStyle!.copyWith(color: formErrorColor),
            ),
        ],
      ),
    );
  }
}
