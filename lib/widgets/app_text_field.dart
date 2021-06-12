import 'package:firebase_sample/widgets/helper_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.initialValue,
    this.helperText,
    this.hintText,
    this.hintTextStyle,
    this.keyboardType,
    this.onChangedHandler,
    this.isRequired = false,
    this.readonly = false,
    this.isPassword = false,
    this.isEmail = false,
    this.controller,
    this.inputTextStyle,
    this.message,
    this.underlineColor,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
  });

  final String? initialValue;
  final String? helperText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChangedHandler;
  final TextEditingController? controller;
  final bool? isRequired;
  final bool? readonly;
  final bool? isPassword;
  final bool? isEmail;
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
            initialValue: initialValue,
            controller: controller,
            maxLines: isPassword! ? 1 : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              hintText: hintText,
              hintStyle: hintTextStyle ?? textTheme.bodyText1,
              counterStyle: textTheme.bodyText1,
            ),
            keyboardType: keyboardType ?? TextInputType.text,
            textInputAction: textInputAction,
            style: inputTextStyle ?? textTheme.bodyText1!,
            inputFormatters: inputFormatters,
            onChanged: onChangedHandler,
            textCapitalization: isEmail! ? TextCapitalization.none : TextCapitalization.sentences,
            readOnly: readonly!,
            obscureText: isPassword!,
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
              style: textTheme.subtitle1!.copyWith(color: underlineColor),
            ),
          ]
        ],
      ),
    );
  }
}
