import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/providers/local_storage.dart';
import 'package:weather/utils/dependencies.dart';

class PlaceSavedCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const PlaceSavedCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        LocalStorage.delete(table: 'PlaceSaved', id: data['id']);
        context.read<WeatherProvider>().setSavedPlaces();
      },
      child: Row(children: [
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(0)),
            child: Image.asset(
                'icons/flags/png/${data['country'].trim().toLowerCase()}.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                package: 'country_icons')),
        const SizedBox(width: 15),
        Text(data['place'], style: const TextStyle(fontSize: 30)),
        const Spacer(),
        OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.solidSave),
            label: const Text('Saved'))
      ]),
    );
  }
}
