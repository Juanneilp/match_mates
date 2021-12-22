import 'package:flutter/material.dart';

class CustomTheme {
  static final darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.pink,
        brightness: Brightness.dark,
      ).copyWith(
        secondary: Colors.green,
      ),
      scaffoldBackgroundColor: Colors.black54,
      selectedRowColor: Colors.green.shade50,
      primaryColor: Colors.pink.shade200,
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white)));

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blueGrey.shade300,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.cyan,
      brightness: Brightness.light,
    ).copyWith(
      secondary: Colors.teal,
    ),
  );
}
