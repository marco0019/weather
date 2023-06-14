import 'package:flutter/material.dart';

ThemeData dark() {
  return ThemeData.dark(useMaterial3: true).copyWith(
      primaryColor: Colors.blue,
      highlightColor: Colors.blue,
      primaryColorDark: Colors.black,
      primaryColorLight: Colors.white,
      cardTheme: CardTheme(
          elevation: 0,
          color: const Color.fromARGB(20, 128, 128, 128),
          shape: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: Colors.grey.withOpacity(.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10)))));
}

ThemeData light() {
  return ThemeData.light(useMaterial3: true).copyWith(
      primaryColor: Colors.blue,
      highlightColor: Colors.blue,
      primaryColorDark: Colors.white,
      primaryColorLight: Colors.black,
      appBarTheme:
          const AppBarTheme(titleTextStyle: TextStyle(color: Colors.black)),
      cardTheme: CardTheme(
          elevation: 0,
          color: Color.fromARGB(20, 128, 128, 128),
          shape: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: Colors.grey.withOpacity(.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10)))));
}
