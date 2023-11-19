import 'package:flutter/material.dart';
import 'package:stringvault/const/colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ConstColors.greyBackground,
    appBarTheme: const AppBarTheme(backgroundColor: ConstColors.tealPrimary),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ConstColors.tealAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(ConstColors.tealAccent),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: ConstColors.tealAccent),
      focusColor: ConstColors.tealAccent,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.tealAccent),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.tealPrimary),
      ),
    ),
  );
}
