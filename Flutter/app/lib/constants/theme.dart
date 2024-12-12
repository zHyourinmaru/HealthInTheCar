import 'package:flutter/material.dart';
import 'textTheme.dart';

class AppTheme {
  static const mainBlue = Color(0xFF19ABD9);
  static const lightBlue = Color(0xFF38CFFF);
  static const mainGreen = Color(0xFF4FA839);
  static const lightGreen = Color(0xFF96C92C);
  static const mainGray = Color(0xFF8D96A1);
  static const mainWhite = Color(0xFFFFFFFF);
  static const mainBlack = Color(0xFF333333);
  static const mainRed = Color(0xFFFF4040);
  static const mainBackground = Color(0xFFEFF3F7);

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light, textTheme: TextAppTheme.lightTextTheme);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark, textTheme: TextAppTheme.lightTextTheme);
}
