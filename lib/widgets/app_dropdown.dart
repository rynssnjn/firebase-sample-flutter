import 'package:firebase_sample/widgets/helper_text.dart';
import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    @required this.value,
    @required this.items,
    @required this.onChanged,
    this.hintText,
    this.hintTextStyle,
    this.textBuilder,
    this.helperText,
    this.isRequired = false,
    this.onButtonTap,
    Key? key,
  }) : super(key: key);

  final T? value;
  final List<T?>? items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? helperText;
  final String Function(T value)? textBuilder;
  final bool? isRequired;
  final VoidCallback? onButtonTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          (items!.contains(value!) ? textBuilder!(value!) : hintText)!,
          style: hintTextStyle ??
              textTheme.headline5!.copyWith(
                color: Colors.black.withOpacity(items!.contains(value) ? 1 : .60),
              ),
        ),
        SizedBox(height: 10),
        DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            onTap: () {
              if (onButtonTap != null) {
                onButtonTap!();
              }
              final focus = FocusManager.instance.primaryFocus;
              if (focus!.hasFocus) {
                focus.unfocus();
              }
            },
            isDense: true,
            items: items!
                .map((item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        textBuilder!(item!),
                        style: textTheme.bodyText2,
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: true,
            hint: HelperText(
              helperText: helperText,
              isRequired: isRequired,
            ),
          ),
        ),
        SizedBox(height: 5),
        Divider()
      ],
    );
  }
}
