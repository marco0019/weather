import 'package:flutter/material.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependencies.dart';

class BottomCustomBar extends StatelessWidget {
  const BottomCustomBar({super.key});
  @override
  Widget build(BuildContext context) {
    final menu = context.watch<MenuProvider>();
    return NavigationBar(
      height: 60,
      onDestinationSelected: (int index) => menu.setIndex(index),
      selectedIndex: menu.currentIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.magnifyingGlass),
          label: 'Search',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: 'Saved',
        ),
        NavigationDestination(
          selectedIcon: Icon(FontAwesomeIcons.gear),
          icon: Icon(FontAwesomeIcons.gear),
          label: 'Settings',
        ),
      ],
    );
  }
}
