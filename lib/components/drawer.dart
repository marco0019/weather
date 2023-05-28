import 'package:flutter/material.dart';
import 'package:weather/providers/drawer_provider.dart';
import 'package:weather/utils/dependencies.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<DrawerProvider>();
    return NavigationDrawer(
        elevation: 10,
        selectedIndex: currentIndex.currentIndex,
        onDestinationSelected: (index) {
          currentIndex.setIndex(index);
          Navigator.pushNamed(context, GLOBAL.PAGES[index]);
        },
        children: const [
          NavigationDrawerDestination(
              icon: Icon(FontAwesomeIcons.magnifyingGlass),
              label: Text('Search')),
          NavigationDrawerDestination(
              icon: Icon(FontAwesomeIcons.floppyDisk),
              label: Text('Places saved')),
          NavigationDrawerDestination(
              icon: Icon(Icons.timer), label: Text('Recently places')),
          NavigationDrawerDestination(
              icon: Icon(FontAwesomeIcons.gear), label: Text('Settings'))
        ]);
  }
}
