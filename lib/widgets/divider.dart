import 'package:firebase_sample/utilities/colors.dart';
import 'package:flutter/material.dart';

/// Widget for divider
class Divider extends StatelessWidget {
  const Divider({
    this.height = 4,
    this.color,
    Key? key,
  }) : super(key: key);

  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: color == null ? dividerGradient : null,
        color: color,
      ),
    );
  }
}
