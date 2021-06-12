import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer(this.space);

  final double space;

  @override
  Widget build(BuildContext context) => SizedBox(height: space);
}

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer(this.space);

  final double space;

  @override
  Widget build(BuildContext context) => SizedBox(width: space);
}
