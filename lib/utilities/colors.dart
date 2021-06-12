import 'package:flutter/material.dart';

final dividerGradient = LinearGradient(
  colors: [
    Color(0xFFD0E0DE),
    Colors.grey[100]!,
  ],
  stops: [0.7, 1],
);

final lightGradientBackground = LinearGradient(
  colors: <Color>[
    Color(0xFFfafffe),
    Color(0xFFe0ebea),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final darkGradientBackground = LinearGradient(
  colors: <Color>[
    Color(0xFF444651),
    Colors.black,
    Color(0xFF191d26),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final cardGradientBackground = LinearGradient(
  colors: [
    iceBlue,
    Color(0xFFfafffe),
    Color(0xFFf3f8f7),
  ],
);

final snowGrand = LinearGradient(
  colors: [
    Color(0xFFFFFFFF),
    Color(0xFFEFF7F6),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const Color formErrorColor = Color(0xfffe8383);

const Color lightGrey = Color(0xffDDE2E7);

const Color iceBlue = Color(0xFFfafffe);
