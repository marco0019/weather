import 'package:flutter/material.dart';
import 'package:weather/pages/frame.dart';
import 'package:weather/pages/init.dart';
import 'package:weather/providers/theme.dart';
import 'package:weather/themes/dark.dart';
import 'package:weather/themes/light.dart';
import 'utils/dependencies.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(GLOBAL.MAIN);
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeModel>();
    return MaterialApp(
      themeAnimationDuration: const Duration(milliseconds: 200),
      theme: light(),
      darkTheme: dark(),
      themeMode: theme.themeMode,
      home: const Frame(),
    );
  }
}
//flutter pub run flutter_launcher_icons:main
//https://jsonplaceholder.typicode.com/albums/1
