import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    border: InputBorder.none,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 5),
  ),
  textTheme: TextTheme(
    // from headline 3 to headline 1
    headline1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 40,
    ),
    // from headline 4 to headline 2
    headline2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 40,
    ),
    // from headline 1 to headline 3
    headline3: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w900,
      fontSize: 22,
    ),
    // from bodyText 1 to headline 4
    headline4: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    // from subtitle 1 to headline 5
    headline5: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    // from headline 6 to headline 6
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.black.withOpacity(0.6),
    ),
    // from subtitle 2 to bodyText 1
    bodyText1: TextStyle(
      color: Colors.black.withOpacity(0.6),
      fontSize: 12,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
    caption: TextStyle(
      color: Colors.black,
      fontSize: 10,
    ),
  ),
);
