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
    final weather = context.watch<WeatherProvider>();
    return Card(
      child: InkWell(
        radius: 10,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: () {
          weather.setData(
              ti: data['place'],
              cCode: data['country'],
              lat: data['latitude'],
              lon: data['longitude']);
          weather.setIndex(0);
        },
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: Image.asset(
                    'icons/flags/png/${data['country'].trim().toLowerCase()}.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    package: 'country_icons')),
          ),
          const SizedBox(width: 15),
          Text(data['place'], style: const TextStyle(fontSize: 30)),
          const Spacer(),
          IconButton.outlined(
              onPressed: () {
                LocalStorage.delete(table: 'PlaceSaved', id: data['id']);
                weather.setSavedPlaces(notify: true);
              },
              icon: const Icon(FontAwesomeIcons.trash)),
          const SizedBox(width: 15)
        ]),
      ),
    );
  }
}
