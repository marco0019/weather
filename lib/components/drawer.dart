import 'package:flutter/material.dart';
import 'package:weather/utils/dependecies.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
        },
      ),
      ListTile(
          leading: const Icon(FontAwesomeIcons.floppyDisk),
          title: const Text('Places saved'),
          onTap: () {
            Navigator.pop(context);
          }),
      ListTile(
        leading: const Icon(FontAwesomeIcons.gear),
        title: const Text('Options'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ]));
  }
}
