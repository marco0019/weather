import 'package:flutter/material.dart';
import 'package:weather/pages/home.dart';
import 'package:weather/pages/list_example.dart';
import 'package:weather/providers/theme.dart';
import 'utils/dependecies.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(GLOBAL.MAIN);
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: context.watch<ThemeModel>().themeMode,
        home: const Home());
  }
}
//https://jsonplaceholder.typicode.com/albums/1
