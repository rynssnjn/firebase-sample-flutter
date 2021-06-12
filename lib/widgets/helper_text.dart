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

    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: helperText,
            style: textTheme.subtitle1,
          ),
          if (isRequired!)
            TextSpan(
              text: ' *',
              style: textTheme.subtitle1!.copyWith(color: formErrorColor),
            ),
        ],
      ),
    );
  }
}
