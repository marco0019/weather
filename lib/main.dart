import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/home.dart';
import 'package:weather/providers/theme.dart';
import 'package:weather/utils/globals.dart';
import 'package:http/http.dart';

void main() => runApp(GLOBAL.MAIN);

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: context.read<ThemeModel>().themeMode,
      home: const Home()
    );
  }
}

Future<Response> fetchAlbum() {
  return get(Uri.parse(GLOBAL.WEATHER_DEFAULT_REQUEST));
}//https://jsonplaceholder.typicode.com/albums/1