import 'package:flutter/material.dart';
import 'package:weather/pages/frame.dart';
import 'package:weather/pages/init.dart';
import 'package:weather/providers/theme.dart';
import 'package:weather/themes/minimal.dart';
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
      themeAnimationDuration: const Duration(milliseconds: 200),
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(primaryColor: Colors.blue, highlightColor: Colors.blue),
      darkTheme: ThemeData.dark(useMaterial3: true)
          .copyWith(primaryColor: Colors.blue, highlightColor: Colors.blue),
      themeMode: context.watch<ThemeModel>().themeMode,
      home: const Frame(),
    );
  }
}
//https://jsonplaceholder.typicode.com/albums/1
