import 'package:flutter/material.dart';
import '../utils/dependecies.dart';
import 'package:weather/providers/init.dart';

final class ChangeTheme extends StatefulWidget {
  const ChangeTheme({super.key});
  @override
  createState() => _ChangeTheme();
}

final class _ChangeTheme extends State<ChangeTheme> {
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(FontAwesomeIcons.moon);
      }
      return const Icon(FontAwesomeIcons.sun);
    },
  );
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeModel>();
    return Switch(
      thumbIcon: thumbIcon,
      value: theme.isDarkMode,
      activeColor: Colors.blueAccent,
      onChanged: (bool value) => theme.toggleTheme(),
    );
  }
}
