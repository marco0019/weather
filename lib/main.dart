import 'package:flutter/material.dart';
import 'package:weather/pages/frame.dart';
import 'package:weather/pages/init.dart';
import 'package:weather/providers/theme.dart';
import 'utils/dependencies.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(GLOBAL.MAIN);
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true).copyWith(
          primaryColor: Colors.blueGrey,
          cardTheme: const CardTheme(
              elevation: 0, color: Color.fromARGB(255, 245, 245, 245))),
      darkTheme: ThemeData.dark(useMaterial3: true),
      //ThemeData.dark(useMaterial3: true)
      themeMode: context.watch<ThemeModel>().themeMode,
      home: const Frame(),
    );
  }
}
//https://jsonplaceholder.typicode.com/albums/1
