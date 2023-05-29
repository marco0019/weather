import 'package:flutter/material.dart';

class MinimalTheme {
  static ThemeData getTheme() {
    return ThemeData.light(useMaterial3: true).copyWith(
      brightness: Brightness.light,
      primaryColor: Colors.blueGrey,
      //accentColor: Colors.lightBlue,
      highlightColor: Colors.blueGrey,
      scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.blueGrey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide.none,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shadowColor: Colors.transparent,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }
}
