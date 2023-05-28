import 'package:flutter/material.dart';
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
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: context.watch<ThemeModel>().themeMode,
      initialRoute: '/search',
      routes: GLOBAL.ROUTES,
    );
  }
}
//https://jsonplaceholder.typicode.com/albums/1
