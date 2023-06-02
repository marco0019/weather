import 'package:flutter/material.dart';

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
              borderSide: BorderSide(color: Colors.grey.withOpacity(.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10)))));
}
