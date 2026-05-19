import 'package:flutter/material.dart';

import 'app_const.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppConst.bgColor,
    primaryColor: AppConst.primaryColor,
    appBarTheme: AppBarThemeData(backgroundColor: AppConst.glassmorphicColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppConst.primaryColor,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppConst.primaryColor),
      ),
    ),
    iconTheme: IconThemeData(color: AppConst.primaryColor),
    cardTheme: CardThemeData(
      color: AppConst.glassmorphicColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    dividerTheme: DividerThemeData(color: Colors.grey.withValues(alpha: 0.3)),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: "Inter",
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppConst.mainTextColor,
      ),
      displayMedium: TextStyle(
        fontFamily: "Inter",
        fontSize: 58,
        color: AppConst.mainTextColor,
      ),
      displaySmall: TextStyle(
        fontFamily: "Inter",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppConst.primaryColor,
      ),
      titleLarge: TextStyle(
        fontFamily: "Inter",
        fontSize: 14,
        letterSpacing: 2,
      ),
      titleMedium: TextStyle(
        fontFamily: "Inter",
        fontSize: 14,
        letterSpacing: 2,
        color: AppConst.primaryColor,
      ),
      titleSmall: TextStyle(
        fontFamily: "Inter",
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppConst.mainTextColor,
      ),
    ),
  );
}
