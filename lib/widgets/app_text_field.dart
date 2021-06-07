import 'package:firebase_sample/widgets/helper_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.helperText,
    this.hintText,
    this.hintTextStyle,
    this.keyboardType,
    this.onChangedHandler,
    this.isRequired = false,
    this.controller,
    this.enabled = true,
    this.inputTextStyle,
    this.message,
    this.underlineColor,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
  });

  final String? helperText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChangedHandler;
  final TextEditingController? controller;
  final bool? isRequired;
  final bool? enabled;
  final TextStyle? inputTextStyle;
  final String? message;
  final Color? underlineColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            enabled: enabled,
            controller: controller,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              hintText: hintText,
              hintStyle: hintTextStyle ?? textTheme.bodyText1!.copyWith(fontSize: 15),
              counterStyle: textTheme.bodyText1,
            ),
            keyboardType: keyboardType ?? TextInputType.text,
            textInputAction: textInputAction,
            style: inputTextStyle ?? textTheme.headline4!.copyWith(fontWeight: FontWeight.w400),
            inputFormatters: inputFormatters,
            onChanged: onChangedHandler,
            textCapitalization: TextCapitalization.sentences,
          ),
          SizedBox(height: 8),
          HelperText(
            helperText: helperText,
            isRequired: isRequired,
          ),
          SizedBox(height: 8),
          Divider(color: underlineColor),
          if (message?.isNotEmpty == true) ...[
            SizedBox(height: 5),
            Text(
              message!,
              style: textTheme.caption!.copyWith(color: underlineColor),
            ),
          ]
        ],
      ),
    );
  }
}
