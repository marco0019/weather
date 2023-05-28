import 'package:flutter/material.dart';
import 'package:weather/utils/dependecies.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 10,
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.magnifyingGlass),
            title: const Text('Search'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/search');
            },
          ),
          ListTile(
              leading: const Icon(FontAwesomeIcons.floppyDisk),
              title: const Text('Places saved'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/search');
              }),
          ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Recently places'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/search');
              }),
          ListTile(
            leading: const Icon(FontAwesomeIcons.gear),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ]));
  }
}
