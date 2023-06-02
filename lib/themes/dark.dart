
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
                  borderSide: BorderSide(color: Colors.grey.withOpacity(.5)),
                  borderRadius: const BorderRadius.all(Radius.circular(10)))));
}
