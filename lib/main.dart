import 'package:flutter/material.dart';
import 'package:weather/pages/pages.dart';
import 'package:weather/providers/providers.dart';
import 'package:weather/themes/themes.dart';
import 'utils/dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.db = await LocalStorage.initDB();
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
