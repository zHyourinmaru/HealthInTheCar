import 'package:app/constants/theme.dart';
import 'package:flutter/material.dart';

class TextAppTheme {
  static const mainBlue = Color(0xFF19ABD9);
  static const lightBlue = Color(0xFF38CFFF);
  static const mainGreen = Color(0xFF4FA839);
  static const lightGreen = Color(0xFF96C92C);
  static const mainGray = Color(0xFF8D96A1);
  static const mainWhite = Color(0xFFFFFFFF);
  static const mainBlack = Color(0xFF333333);
  static const mainRed = Color(0xFFFF4040);
  static const mainBackground = Color(0xFFEFF3F7);

  static TextTheme lightTextTheme = const TextTheme(
      labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          color: AppTheme.mainBlack,
          fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 24,
          color: AppTheme.mainBlack,
          fontWeight: FontWeight.bold),
      labelLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 36,
          color: AppTheme.mainBlack,
          fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: AppTheme.mainGray,
          fontWeight: FontWeight.normal),
      displayMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 24,
          color: AppTheme.mainRed,
          fontWeight: FontWeight.bold),
      displayLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 36,
          color: AppTheme.mainWhite,
          fontWeight: FontWeight.bold));
}
